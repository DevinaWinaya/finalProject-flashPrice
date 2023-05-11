﻿<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="flashPrice.pages.home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPh" runat="server">

    <asp:UpdatePanel ID="updAction" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" style="display: none">
        <ContentTemplate>
            <asp:HiddenField ID="hiddenProductID" runat="server" />
            <asp:Button ID="productDetailBtn" runat="server" Text="Product Detail" OnClick="productDetailBtn_Click" Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="updatePanelSearchResultRepeater" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Literal runat="server" ID="testLit"></asp:Literal>
            <div id="resultDiv" runat="server">
                <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fbd746;">
                    <a class="navbar-brand text-white" href="#">
                        <img src="assets/images/flashPriceLogo.png" style="width: 150px;" /></a>
                    <span></span>
                    <div class="navbar-nav col-md-8 mx-auto">
                        <asp:TextBox runat="server" ID="navSearchTextBox" CssClass="form-control mr-2 col-md-5" placeHolder="Temukan produkmu disini . . ."></asp:TextBox>
                        <asp:DropDownList runat="server" ID="categoryProductDD" CssClass="form-control col-md-2 mr-2">
                            <asp:ListItem Text="Pilih Kategori" Value=""></asp:ListItem>
                            <asp:ListItem Text="Makanan" Value="C001"></asp:ListItem>
                            <asp:ListItem Text="Minuman" Value="C002"></asp:ListItem>
                        </asp:DropDownList>

                        <asp:LinkButton runat="server" ID="navSearchBtn" OnClick="navSearchBtn_Click" CssClass="btn btn-light"><i class="fa fa-search"></i></asp:LinkButton>
                    </div>

                    <span class="navbar-text">Bandingkan dan temukan produk pilihanmu dengan FlashPrice
                    </span>
                </nav>

                <div id="queryResultDiv" class="row mx-auto col-md-8 mt-3 col-xs-12 col-sm-12 border border-secondary-50" runat="server">
                    <asp:Literal ID="litError" runat="server"></asp:Literal>
                    <asp:Repeater ID="resultRepeater" runat="server" OnItemDataBound="resultRepeater_ItemDataBound" OnItemCommand="resultRepeater_ItemCommand">
                        <ItemTemplate>
                            <div class="col-md-3 mb-3 d-flex align-items-stretch">
                                <div class="card mt-3 mb-3 col-md-12">
                                    <div class="card-header bg-white">
                                        <asp:Literal ID="litProductImg" runat="server"></asp:Literal>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <span class="text-left col-md-12">
                                                <img src="<%#Eval("productImageUrl") %>" style="border-radius: 10px; height: auto; width: 280px;" class="img-fluid" alt="Image Not Found" />
                                            </span>

                                            <span class="mt-3 mb-2">
                                                <asp:Label ID="productNameLbl" CssClass="h6" Style="color: #ee8000;" runat="server" Text='<%#Eval("productName") %>'></asp:Label>
                                            </span>
                                        </div>
                                        <div class="row">
                                            <span>
                                                <i class="fa fa-money-bill-1 mr-2"></i>
                                                Rp.<asp:Label ID="productPriceLbl" CssClass="ml-1" runat="server" Text='<%#Eval("productPrice")%>'></asp:Label>
                                            </span>
                                        </div>
                                        <div class="row">
                                            <span>
                                                <i class="fa fa-store mr-2"></i>
                                                <asp:Label ID="miniMarketName" runat="server" Text='<%#Eval("miniMarketName") %>'></asp:Label>
                                            </span>
                                        </div>
                                        <div class="row">
                                            <span>
                                                <i class="fa fa-map-location mr-2"></i>
                                                <asp:Label ID="miniMarketAddress" Text='<%#Eval("miniMarketAddress")%>' runat="server"></asp:Label>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row mt-3 card-footer bg-white">
                                        <asp:LinkButton runat="server" CssClass="btn btn-warning btn-sm align-self-start btn-block text-white" BackColor="#ee8000" OnClientClick='<%# Eval("productID", "productDetail(\"{0}\"); return false;") %>'><i class="fa fa-search mr-2"></i>Detail</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>


    <div id="modalDialogProductDetail" class="modal fade modal-dialog-add" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="overflow-y: auto;">
        <div class="modal-dialog modal-lg" style="max-width: 1080px">
            <div class="modal-content">
                <asp:UpdatePanel ID="updatePanelProductDetail" runat="server" UpdateMode="Conditional"
                    ChildrenAsTriggers="false">
                    <Triggers>
                    </Triggers>
                    <ContentTemplate>
                        <div class="modal-header text-white" style="background-color: #fbd746">
                            <asp:Label ID="headerNameLbl" runat="server"></asp:Label>
                            <a type="button" class="close text-white" data-dismiss="modal">
                                <i class="fa fa-times text-white" aria-hidden="true"></i>
                            </a>
                        </div>
                        <div class="modal-body pt-2" id="modal-body">
                            <div class="card col-md-3">
                                <div class="card-header bg-white">
                                    <asp:Image runat="server" ID="productImageUrlPopup" Style="width: 180px; height: auto;" />
                                </div>
                                <div class="card-body">
                                    <div class="row mt-2">
                                        <asp:Image runat="server" ID="miniMarketImageUrlPopup" Style="width: 100px; height: auto;" />
                                    </div>
                                    <div class="row  mt-2">
                                        <asp:Label runat="server" CssClass="h6 mr-2" style="color:#ee8000" ID="productNamePopupLbl"></asp:Label>
                                    </div>
                                    <div class="row mt-2">
                                        <span class="badge badge-warning">
                                            <span class="h6">Rp.</span>
                                            <asp:Label runat="server" CssClass="h6 ml-1 " ID="productPricePopupLbl"></asp:Label>
                                        </span>
                                    </div>

                                </div>
                            </div>
                            <div class="mt-2 col-md-12">
                                <div class="row">
                                    <span class="font-weight-bold">Deskripsi Produk</span>
                                </div>
                                <div class="row">
                                    <asp:Label runat="server" Style="text-align: justify;" ID="productDescPopupLbl"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        var _baseUrl = '<%=ResolveUrl("~/")%>';

        function productDetail(productID) {
            if (productID != '') {
                $('#<%= hiddenProductID.ClientID %>').val(productID);
            }

            $('#<%= productDetailBtn.ClientID %>').click();
        }

    </script>

</asp:Content>
