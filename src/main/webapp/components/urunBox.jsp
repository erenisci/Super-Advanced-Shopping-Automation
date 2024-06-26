<%-- 
    Document   : urunBox
    Created on : 5 Ara 2023, 05:01:37
    Author     : iscie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="box">
    <div class="imgBox">
        <img
            class="picture"
            src="<%out.print(product.getUrunUrl());%>"
            alt="<%out.print(product.getUrunIsim());%>"
            />
        <div class="stokDiv"><p class="stok">STOK: <%out.print(product.getUrunStok());%></p></div>
    </div>
    <div class="name-value">
        <p class="prod-name value-urunIsim"><%out.print(product.getUrunIsim());%></p>
        <p class="value-urunIsim"><span class="value-urunFiyat"><%out.print(product.getUrunFiyat());%></span><span class="value-tl"> TL</span></p>
    </div>
    <div class="center">
        <form action="purchase.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="<%out.print(product.getUrunId());%>"/>
            <input type="hidden" name="productUserId" value="<%out.print(product.getUrunKullaniciId());%>"/>
            <input type="hidden" name="productName" value="<%out.print(product.getUrunIsim());%>"/>
            <input type="hidden" name="productUrl" value="<%out.print(product.getUrunUrl());%>"/>
            <input type="hidden" name="productPrice" value="<%out.print(product.getUrunFiyat());%>"/>
            <input type="hidden" name="productStock" value="<%out.print(product.getUrunStok());%>"/>
            <input type="hidden" name="productInfo" value="<%out.print(product.getUrunAciklama());%>"/>
            <input type="hidden" name="page" value="<%out.print(pageParam);%>"/>
            <input type="hidden" name="search" value="<%out.print(searchKeyword);%>"/>
            <input type="hidden" name="category" value="<%out.print(categoryKeyword);%>"/>
            <input type="hidden" name="sort" value="<%out.print(sortOption);%>"/>
            <button class="buy" type="submit">Ürünü Önizle</button>
        </form>
    </div>
</div>