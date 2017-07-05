<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterSheet.aspx.cs" Inherits="TheDungeon2.CharacterSheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:Repeater ID="Repeater1" runat="server" DataSourceID="CharacterDataSource">
		<ItemTemplate>
			<asp:TextBox ID="NameTextBox" runat="server" Text='<%# Eval("Name") %>'></asp:TextBox>
			<br />
			<asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active"  />
			<br />
			<asp:TextBox ID="SheetTextBox" runat="server" Text='<%# Eval("Sheet") %>' Height="950px" TextMode="MultiLine" Width="1133px"></asp:TextBox>
		</ItemTemplate>
	</asp:Repeater>
	<asp:SqlDataSource ID="CharacterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CharacterSheets.CharacterId, CharacterSheets.Sheet, Characters.Active AS Expr1, Characters.DateModified AS Expr2, Characters.Name AS Expr3, Characters.[User] AS Expr4, Characters.Id AS Expr5, Characters.Id, Characters.[User], Characters.Name, Characters.Active, Characters.DateModified, Characters.DateCreated FROM Characters INNER JOIN CharacterSheets ON Characters.Id = CharacterSheets.CharacterId WHERE (Characters.Id = @CharId)">
		<SelectParameters>
			<asp:RouteParameter Name="CharId" RouteKey="CharId" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
