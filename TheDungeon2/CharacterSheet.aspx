<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterSheet.aspx.cs" Inherits="TheDungeon.CharacterSheet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script>
	var sheetEdited = false;	//tracks if the sheet has been changed since it was last saved

	function onEdit() {
		sheetEdited = true;
	}

	setInterval(checkEdited, 5000);	//call the checkEdited function every 5 seconds

	function checkEdited() {	//if data has been edited, send the update to the server
		if (sheetEdited) {
			sendUpdate();
			sheetEdited = false;
		}
	}

	function sendUpdate() {		//update the character data on the server
		//get the url parameters
		var params = getURLParameter("id");

		//get the charId parameter
		var charId = params[0].split(":")[1];		//TODO: make this more robust. it needs to check for parameter name

		//TODO: get other function parameters from sheet
		var sheetText = document.getElementById('<%=SheetTextBox.ClientID%>').value;
		var nameText = document.getElementById('<%=NameTextBox.ClientID%>').value;
		var active = document.getElementById('<%=ActiveCheckBox.ClientID%>').value;

		// create the json object
		var options = {
			error: function (msg) { alert(msg.d); },
			type: "POST", url: "CharacterSheetWebService.asmx/SaveCharacterData",
			data: { CharId: charId, CharName: JSON.stringify({ nameText }), CharActive: active, CharSheetText: JSON.stringify({sheetText}) },
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			async: true,
			success: function (response) { var results = response.d; }
		};
		$.ajax(options);		//use ajax to call the SaveCharacterData WebMethod
	}

	//gets a parameter from the URL, by name
	function getURLParameter(name) {
		return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
	}

</script>
	<asp:Label ID="NameLabel" runat="server" Text="Character Name"></asp:Label>
	<asp:TextBox ID="NameTextBox" runat="server" OnKeyPress="javascript:onEdit();"></asp:TextBox>
	<br />
	<asp:Label ID="DateCreatedLabel" runat="server" Text="Created On"></asp:Label>
	<asp:TextBox ID="DateCreatedTextBox" runat="server"></asp:TextBox>
	<br />
	<asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active" OnChange="javascript:onEdit();"/> 
	<br />
	<br />
	<asp:TextBox ID="SheetTextBox" runat="server" Height="950px" TextMode="MultiLine" Width="1133px"  OnKeyPress="javascript:onEdit();" OnUnload="OnPageUnload"></asp:TextBox>
	<br />
	<asp:FileUpload ID="CharacterSheetFileUpload" runat="server" />
	<asp:Button ID="UploadButton" runat="server" OnClick="UploadButton_Click" Text="Upload Character Sheet" />
	<asp:Button ID="DownloadButton" runat="server" OnClick="DownloadButton_Click" Text="Download Character Sheet" />
	<asp:SqlDataSource ID="CharacterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [User], [Name], [Active], [DateModified], [DateCreated] FROM [Characters] WHERE (([User] = @User) AND ([Id] = @Id))">
		<SelectParameters>
			<asp:SessionParameter Name="User" SessionField="UserId" Type="String" />
			<asp:QueryStringParameter Name="Id" QueryStringField="Id" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:Button ID="DeleteCharacterButton" runat="server" OnClick="DeleteCharacterButton_Click" Text="Delete" />
</asp:Content>
