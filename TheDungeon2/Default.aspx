<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TheDungeon._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Welcome to The Dungeon</h1>
        <p class="lead">The Dungeon is a free cloud-based tabletop Roleplaying Game character sheet manager. It allows users to store, view and edit their character sheets, without having to worry about where they are saved.</p>
        <p><a runat="server" href="~/Account/Login" class="btn btn-primary btn-lg">Enter The Dungeon &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Cloud-based Storage</h2>
            <p>
                Characters are stored in the cloud, so you can access them from any device with an internet connection</p>
            <p>
                &nbsp;</p>
        </div>
        <div class="col-md-4">
            <h2>Tagging and Filtering</h2>
            <p>
                Apply tags to your characters, sorting them by system, campaign, or anything els you want. You can also filter your character list by tag, making it easy to find the character you are looking for.</p>
            <p>
                &nbsp;</p>
        </div>
        <div class="col-md-4">
            <h2>Offline accessability</h2>
            <p>
                Download the character sheet file to your computer, so you have access to it offline. You can later upload an updated sheet, keeping your character up to date.</p>
            <p>
                &nbsp;</p>
        </div>
    </div>

</asp:Content>
