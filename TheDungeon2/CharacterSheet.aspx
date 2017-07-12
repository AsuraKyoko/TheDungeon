<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterSheet.aspx.cs" Inherits="TheDungeon2.CharacterSheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:Repeater ID="Repeater1" runat="server" DataSourceID="CharacterDataSource">
		<ItemTemplate>
			<asp:TextBox ID="NameTextBox" runat="server" Text='<%# Eval("CharName") %>'></asp:TextBox>
			<br />
			<asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active" Value='<%# Eval("CharActive") %>' />
			<br />
		</ItemTemplate>
	</asp:Repeater>
	<br />
	<asp:TextBox ID="SheetTextBox" runat="server" Height="950px" TextMode="MultiLine" Width="1133px" OnTextChanged="SheetTextBox_TextChanged"></asp:TextBox>
	<asp:FileUpload ID="CharacterSheetFileUpload" runat="server" />
	<asp:Button ID="UploadButton" runat="server" OnClick="UploadButton_Click" Text="Upload Character Sheet" />
	<asp:Button ID="DownloadButton" runat="server" OnClick="DownloadButton_Click" Text="Download Character Sheet" />
	<asp:SqlDataSource ID="CharacterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CharacterSheets.Id As SheetId, Characters.Active AS CharActive, Characters.DateModified AS CharDateModified, Characters.Name AS CharName, Characters.[User] AS CharUser, Characters.Id AS CharId, Characters.Id, Characters.[User], Characters.Name, Characters.Active, Characters.DateModified, Characters.DateCreated FROM Characters INNER JOIN CharacterSheets ON Characters.Id = CharacterSheets.CharacterId WHERE (Characters.Id = @CharId)">
		<SelectParameters>
			<asp:RouteParameter Name="CharId" RouteKey="CharId" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:Timer ID="SaveTimer" runat="server" OnTick="SaveTimer_Tick">
	</asp:Timer>
</asp:Content>
