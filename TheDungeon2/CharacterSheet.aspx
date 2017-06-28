<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterSheet.aspx.cs" Inherits="TheDungeon2.CharacterSheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
	<br />
	<br />
	<asp:TextBox ID="SheetTextBox" runat="server" Height="950px" TextMode="MultiLine" Width="1133px"></asp:TextBox>
</asp:Content>
