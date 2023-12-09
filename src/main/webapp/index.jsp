<%-- 
    Document   : index
    Created on : 1 Ara 2023, 02:02:37
    Author     : iscie
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.web.programming.project.Categories"%>
<%@page import="com.mycompany.web.programming.project.DBConnection"%>
<%@page import="com.mycompany.web.programming.project.DBOperations"%>
<%@page import="com.mycompany.web.programming.project.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    />
    <link
      rel="preconnect"
      href="https://fonts.googleapis.com"
    />
    <link
      rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="css/index.css"
    />
    <link
      rel="stylesheet"
      href="css/general.css"
    />
    <link
      rel="stylesheet"
      href="css/urunBox.css"
    />
    <title>Index</title>    
  </head>
  <body>
      
    <!-- HEADER -->
    <header>
        <p><a class="logo" href="index.jsp">LOGO</a></p>
      <div class="log-reg">
          <span><a class="logR" href="login.jsp">GİRİŞ YAP</a></span>
        <span><a class="logR" href="register.jsp">KAYIT </a></span>
      </div>
    </header>

    <!-- CONTENT -->
    <main>
        
        <!-- CATEGORIES NAV -->
        <nav class="nav-cat">
        <%  
            String pageParam = "";
            if (request.getParameter("page") != null) pageParam = request.getParameter("page");
            
            String searchKeyword = "";
            String searchKey = request.getParameter("search");
            boolean searchTF = true;
            if(request.getParameter("search") != null && request.getParameter("search").matches("[a-zA-ZçÇğĞıİöÖşŞüÜ ]+")) searchKeyword = request.getParameter("search").trim();
            else searchTF = false;
            
            String categoryKeyword = "";
            if (request.getParameter("category") != null) categoryKeyword = request.getParameter("category");
            
            String sortOption = "";
            if (request.getParameter("sort") != null) sortOption = request.getParameter("sort");

            String sqlCategoryCount = "";
            try (ResultSet resultCat = DBOperations.executeQuery("SELECT * FROM kategoriler ORDER BY urunKategori_ad")) { 
                sqlCategoryCount = "SELECT COUNT(*) as total FROM urunler u LEFT JOIN kategoriler k ON u.urunKategori_id = k.urunKategori_id WHERE k.urunKategori_id = u.urunKategori_id;";
                int TotalcategoryCount = DBOperations.getAllProduct(sqlCategoryCount);
        %>
        <div class="category-div <%if(TotalcategoryCount < 1) out.print("disabled-link");%>">
          <a class="<%
                 if(request.getParameter("category") == "") out.print("category-link-active");
                 else out.print("category-link");%>"
             href="?page=&search=&category=&sort=">
              <div class=
                   "<%
                       if (request.getParameter("category") == "") out.print("div-category-link-active");
                       else out.print("div-category-link");
                   %>" 
                  <span>TÜM ÜRÜNLER</span>
                <span class="category-span">
                  (<%out.print(TotalcategoryCount);%>)  
                </span>
              </div>
          </a>
        </div>
        <%
                List<Categories> categoryResults = new ArrayList<>();
                while (resultCat.next()) {
                    Categories category = new Categories();
                    category.setCategoryId(resultCat.getInt("urunKategori_id"));
                    category.setCategoryName(resultCat.getString("urunKategori_ad"));
                    
                    // CATEGORY COUNT
                    sqlCategoryCount = "SELECT COUNT(*) as total FROM urunler u LEFT JOIN kategoriler k ON u.urunKategori_id = k.urunKategori_id WHERE u.urunKategori_id = " + category.getCategoryId();
                    category.setCategoryCount(DBOperations.getAllProduct(sqlCategoryCount));
                    categoryResults.add(category);
                }
                
                for (Categories category : categoryResults) {
                    
                    Integer categoryId = category.getCategoryId();
                    String categoryParam = request.getParameter("category");
                    boolean myCss = categoryId.toString().equals(categoryParam);
        %>
          <div class="category-div <%if(category.getCategoryCount() < 1) out.print("disabled-link");%>">
              <a class=
                "<%
                if(myCss) out.print("category-link-active");
                else out.print("category-link");
                %>" href="?page=&search=<%out.print(searchKeyword);%>&category=<%out.print(category.getCategoryId());%>&sort=<%out.print(sortOption);%>">
                  <div class=
                    "<%
                        if(myCss) out.print("div-category-link-active");
                        else out.print("div-category-link");
                    %>">
                      <span>
                          <%out.print(category.getCategoryName().toUpperCase());%>
                      </span>
                    <span class="category-span">(<%out.print(category.getCategoryCount());%>)</span>
                  </div>
            </a>
          </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </nav>
        
        <!-- SEARCH NAV -->
        <div class="search-productDiv">
            <div class="searchBar">
                <form class="form-select" method="get">
                    <!-- PAGE -->
                    <input type="hidden" name="page" value="<%
                                                                if (pageParam == session.getAttribute("page"))
                                                                    out.print(pageParam);
                                                                else
                                                                    out.print("1");
                                                            %>"/>
                    <!-- SEARCH OPTION -->
                    <div class="search">
                        <div class="search-bar">
                            <input class="searchText" type="text" name="search" value="<%out.print(searchKeyword);%>" 
                                    placeholder="<%
                                        boolean flag = false;
                                        if (searchTF || searchKey == null || searchKey == "") out.print("Arama");
                                        else {
                                            out.print("Türkçe karakter girin...");
                                            flag = true;
                                        }%>
                            "/>
                            <input class="searchBut" type="submit" value="ARA"/>
                        </div>
                        
                        <!-- FOR CATEGORY -->
                        <input type="hidden" name="category" value="<%out.print(categoryKeyword);%>"/>
                        
                        <!-- SORTING OPRION -->
                        <div class="sorting-options">
                            <select class="search-select" name="sort">
                                <option value="">Sırala</option>
                                <option value="AZ" <%= "AZ".equals(sortOption) ? "selected" : "" %>>A-Z</option>
                                <option value="ZA" <%= "ZA".equals(sortOption) ? "selected" : "" %>>Z-A</option>
                                <option value="priceAsc" <%= "priceAsc".equals(sortOption) ? "selected" : "" %>>Fiyat Artan</option>
                                <option value="priceDesc" <%= "priceDesc".equals(sortOption) ? "selected" : "" %>>Fiyat Azalan</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
                            
        <!-- PRODUCT PAGE -->
        <div class="productDiv">
        <%
            session.setAttribute("page", pageParam);
            
            // PAGE
            int urunlerPerPage = 8;
            int currentPage = 1;
            
            if (pageParam != null && !pageParam.isEmpty()) currentPage = Integer.parseInt(pageParam);
            int startIndex = (currentPage - 1) * urunlerPerPage;
            
            // ORDER
            String colmnSort = "urunIsim";
            if ("ZA".equals(sortOption)) {
                colmnSort = "urunIsim DESC";
            } else if ("priceAsc".equals(sortOption)) {
                colmnSort = "urunFiyat ASC";
            } else if ("priceDesc".equals(sortOption)) {
                colmnSort = "urunFiyat DESC";
            }
            
            String sql = "";
            String limit = "ORDER BY " + colmnSort + " LIMIT " + startIndex + "," + urunlerPerPage;
            if (!(categoryKeyword != null && !categoryKeyword.isEmpty())) {
                sql = "SELECT * FROM urunler ";
                if (searchKeyword != null && !searchKeyword.isEmpty()) sql += "WHERE urunIsim COLLATE utf8mb4_turkish_ci LIKE '" + searchKeyword + "%' ";
            } else {
                sql = "SELECT u.*" + "FROM urunler u " +
                        "LEFT JOIN kategoriler k ON u.urunKategori_id = k.urunKategori_id " +
                        "WHERE k.urunKategori_id = '" + categoryKeyword + "' ";
                if (searchKeyword != null && !searchKeyword.isEmpty()) sql += "AND urunIsim COLLATE utf8mb4_turkish_ci LIKE '" + searchKeyword + "%' ";
            }
            sql += limit;
            
            try (ResultSet result = DBOperations.executeQuery(sql)) {
                List<Product> searchResults = new ArrayList<>();
                while (result.next()) {
                    Product urun = new Product();
                    urun.setUrunIsim(result.getString("urunIsim").substring(0, 1).toUpperCase() + result.getString("urunIsim").substring(1));
                    urun.setUrunUrl(result.getString("urunUrl"));
                    urun.setUrunFiyat(result.getFloat("urunFiyat"));
                    urun.setUrunStok(result.getInt("urunStok"));
                    urun.setUrunNewPageUrl();
                    searchResults.add(urun);
                }

                for (Product product : searchResults) {
        %>
        <%@include file="components/urunBox.jsp"%>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        </div>
        
        <!-- PAGINATION -->
        <div class="pagination">
        <%
            int totalProduct = 0;
            
            if (categoryKeyword != null && !categoryKeyword.isEmpty()) totalProduct = DBOperations.getTotalCategoryProduct(sql);
            else totalProduct = DBOperations.getTotalQueryProduct(sql);
            
            int totalPage = (int) Math.ceil((double) totalProduct / urunlerPerPage);
            int rangeStart = Math.max(currentPage - 1, 1);
            int rangeEnd = Math.min(currentPage + 1, totalPage);
            if (currentPage > 1) out.println("<a class='non-active' href='index.jsp?page=1&search=" + searchKeyword + "&category=" + categoryKeyword + "&sort=" + sortOption + "'>&lt;&lt;</a>");
            if (currentPage > 1) out.println("<a class='marg-right non-active' href='index.jsp?page=" + (currentPage - 1) + "&search=" + searchKeyword + "&category=" + categoryKeyword + "&sort=" + sortOption + "'>&lt;</a>");
            else {
                out.println("<a class='non-active hid'>&lt;&lt;</a>");
                out.println("<a class='hid-marg-right non-active hid'>&lt;</a>");
            }

            for (int i = rangeStart; i <= rangeEnd; i++) {
                if (i == currentPage) {
                    out.println("<div class='active'>" + i + "</div>");
                } else {
                    out.println("<a class='non-active' href='index.jsp?page=" + i + "&search=" + searchKeyword + "&category=" + categoryKeyword + "&sort=" + sortOption + "'>" + i + "</a>");
                }
            }

            if (currentPage < totalPage) out.println("<a class='marg-left non-active' href='index.jsp?page=" + (currentPage + 1) + "&search=" + searchKeyword + "&category=" + categoryKeyword + "&sort=" + sortOption + "'>&gt;</a>");
            if (currentPage < totalPage) out.println("<a class='non-active' href='index.jsp?page=" + totalPage + "&search=" + searchKeyword + "&category=" + categoryKeyword + "&sort=" + sortOption + "'>&gt;&gt;</a>");
            else {
                out.println("<a class='hid-marg-left non-active hid'>&lt;&lt;</a>");
                out.println("<a class='non-active hid'>&lt;</a>");
            }
        %>
        </div>
      </div>
    </main>
  
    <!-- FOOTER -->
    <footer class="footer">
      <div class="container footer-container grid--footer">
        <div class="boxLogo">
          <a class="footer-logo footer-link" href="index.jsp">
              <p class="logoFoot">LOGO</p>
          </a>
          <ul class="social-links">
            <li>
              <a class="footer-link" href="#">FACEBOOK</a>
            </li>
            <li>
              <a class="footer-link" href="#">TWITTER</a>
            </li>
            <li>
              <a class="footer-link" href="#">INSTAGRAM</a>
            </li>
          </ul>
          <%
            Date currentDate = new Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentDate);
            int currentYear = calendar.get(Calendar.YEAR);
          %>
          <p class="copyright">
            Copyright &copy; <span><%out.print(currentYear);%></span> by Lorem, Inc. Bütün Hakları Saklıdır.
          </p>
        </div>
        <div class="boxAddress">
          <p class="footer-heading">İletişim</p>
          <address class="contacts">
            <p class="address">Lorem Ipsum Dolor</p>
            <p>
              <a class="footer-link">123-456-7890</a><br />
              <a class="footer-link">lorem@ipsum.com</a>
            </p>
          </address>
        </div>
        <nav class="boxNav">
          <p class="footer-heading">Hesap</p>
          <ul class="footer-nav">
            <li><a class="footer-link" href="#">Giriş Yap</a></li>
            <li><a class="footer-link" href="#">Hesap Oluştur</a></li>
            <li><a class="footer-link" href="#">iOS Uygulaması</a></li>
            <li><a class="footer-link" href="#">Android Uygulaması</a></li>
          </ul>
        </nav>
        <nav class="boxNav">
          <p class="footer-heading">Şirket</p>
          <ul class="footer-nav">
            <li><a class="footer-link" href="#">Hakkımızda</a></li>
            <li><a class="footer-link" href="#">İş Ortaklarımız</a></li>
            <li><a class="footer-link" href="#">Kariyer</a></li>
          </ul>
        </nav>
        <nav class="boxNav">
          <p class="footer-heading">Yardım</p>
          <ul class="footer-nav">
            <li><a class="footer-link" href="#">Yardım Merkezi</a></li>
            <li><a class="footer-link" href="#">Gizlilik & Şartlar</a></li>
            <li><a class="footer-link" href="#">Sıkça Sorulan Sorular</a></li>
          </ul>
        </nav>
      </div>
    </footer>
    
    <script>
        document.querySelector('.form-select').addEventListener('change', function () {
            this.submit();
        });
        
        let flag = <%out.print(flag);%>
        if(flag == true) alert("Türkçe karakter girin...");
        
        let productNameInput = document.querySelector('.prod-name');
        let productName = productNameInput.innerHTML;
        if (productName.length > 20) {
            productName = productName.substring(0, 17) + "...";
            productNameInput.innerHTML = productName;
        }
    </script>
  </body>
</html>
