<%@ Page Title="Character List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterList.aspx.cs" Inherits="TheDungeon.About" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<script>
		function ShowAddCharacterPanel() {
			document.getElementById('AddCharacterPanel').style.display = 'block';
			document.getElementById('AddCharacterButton').style.display = 'none';
		};
		function HideAddCharacterPanel() {
			document.getElementById('AddCharacterPanel').style.display = 'none';
			document.getElementById('AddCharacterButton').style.display = 'block';
		};
	</script>
	<h2><%: Title %>.</h2>
	<asp:TextBox ID="FilterTextBox" runat="server"></asp:TextBox>
		<asp:CheckBox ID="RetiredCheckBox" runat="server" Text="Show Retired Characters" />
		<br />
	<input type="button" ID="AddCharacterButton" Value="Add Character" onclick="ShowAddCharacterPanel();" />
	<div ID="AddCharacterPanel">
		<asp:RequiredFieldValidator ID="CharacterNameFieldValidator" ControlToValidate="AddCharacterNameTextBox" runat="server" ErrorMessage="You must enter a character name"></asp:RequiredFieldValidator>
		<br />
		<asp:TextBox ID="AddCharacterNameTextBox" runat="server"></asp:TextBox>
		<br />
		<asp:Label ID="Label1" runat="server" Text="Upload Character sheet file:"></asp:Label>
		<br />
		<asp:FileUpload ID="AddCharacterFileUpload" runat="server" />
		<asp:Button ID="ConfirmAddButton" runat="server" OnClick="ConfirmAddButton_Click" Text="Create" />
		<input type="button" ID="CancelAddButton" onclick="HideAddCharacterPanel();" Value="Cancel" formnovalidate="formnovalidate" />
	</div>
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
