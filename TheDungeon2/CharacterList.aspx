<%@ Page Title="Character List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterList.aspx.cs" Inherits="TheDungeon.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <asp:TextBox ID="FilterTextBox" runat="server"></asp:TextBox>
        <asp:CheckBox ID="RetiredCheckBox" runat="server" Text="Show Retired Characters" />
        <asp:Table ID="CharacterTable" runat="server" GridLines="Horizontal">
            <asp:TableRow runat="server">
                <asp:TableCell ID="Name" runat="server">Character 1</asp:TableCell>
                <asp:TableCell ID="Tags" runat="server">Tag1, Tag2</asp:TableCell>
                <asp:TableCell ID="Active" runat="server"></asp:TableCell>
                <asp:TableCell ID="Timestamp" runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
</asp:Content>
