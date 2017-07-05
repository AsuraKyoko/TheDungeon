﻿<%@ Page Title="Character List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterList.aspx.cs" Inherits="TheDungeon.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<h2><%: Title %>.</h2>
	<asp:TextBox ID="FilterTextBox" runat="server"></asp:TextBox>
		<asp:CheckBox ID="RetiredCheckBox" runat="server" Text="Show Retired Characters" />
		<br />
	<asp:Button ID="AddCharacterButton" runat="server" Text="Add Character" OnClick="AddCharacterButton_Click" />
	<br />
	<asp:GridView ID="CharactersGridView" runat="server" AutoGenerateColumns="False" DataSourceID="CharacterListDataSource" AllowSorting="True">
		<Columns>
			<asp:HyperLinkField DataTextField="Name" HeaderText="Name" NavigateUrl="~/CharacterSheet.aspx" />
			<asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" ReadOnly="True" />
			<asp:BoundField DataField="DateModified" HeaderText="Last Modified" />
			<asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="DateCreated" ReadOnly="True" />
		</Columns>
	</asp:GridView>
	<asp:SqlDataSource ID="CharacterListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [Name], [Active], [DateModified], [DateCreated] FROM [Characters] WHERE ([User] = @User)">
		<SelectParameters>
			<asp:SessionParameter Name="User" SessionField="UserId" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
