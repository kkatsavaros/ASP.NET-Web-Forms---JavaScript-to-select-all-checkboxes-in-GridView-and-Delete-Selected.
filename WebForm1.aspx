<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="s02.JavaScriptConfirmOnGridviewDelete.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
        <div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None" 
                BorderWidth="1px" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound">
                <Columns>

                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkBoxSelectAll" onclick="HeaderCheckBoxClick(this);" runat="server" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" onclick="ChildCheckBoxClick(this);" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">
                        <HeaderTemplate>
                            <asp:LinkButton ID="lbDeleteSelected" runat="server" CausesValidation="False" 
                                Text="Delete Selected" OnClick="lbDeleteSelected_Click"></asp:LinkButton>
                        </HeaderTemplate>
                        
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" 
                                Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="ID" SortExpression="ID">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    <asp:BoundField DataField="DepartmentId" HeaderText="DepartmentId" SortExpression="DepartmentId" />
                </Columns>

                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#330099" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                <SortedAscendingCellStyle BackColor="#FEFCEB" />
                <SortedAscendingHeaderStyle BackColor="#AF0101" />
                <SortedDescendingCellStyle BackColor="#F6F0C0" />
                <SortedDescendingHeaderStyle BackColor="#7E0000" />
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CustomersConnectionString %>" 
                DeleteCommand="DELETE FROM [Employees] WHERE [ID] = @ID" 
                InsertCommand="INSERT INTO [Employees] ([ID], [Name], [Gender], [DepartmentId]) VALUES (@ID, @Name, @Gender, @DepartmentId)" 
                SelectCommand="SELECT * FROM [Employees]" 
                UpdateCommand="UPDATE [Employees] SET [Name] = @Name, [Gender] = @Gender, [DepartmentId] = @DepartmentId WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="DepartmentId" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="DepartmentId" Type="Int32" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>


            <script type="text/javascript" language="javascript">

                // Τσεκάρουμε το Header CheckBox και επιλέγονται όλα τα checkBoxes από όλες τις γραμμές.
                function HeaderCheckBoxClick(checkbox) {

                    var gridView = document.getElementById("GridView1");

                    // Loop through each data row.
                    for (i = 1; i < gridView.rows.length; i++) {
                        gridView.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = checkbox.checked;
                    }
                }

                // Όταν κάποια γραμμή γίνει uncheck κάποιο Item,  τότε το Heder ChecoBox να γίνει και αυτό uncheck.
                function ChildCheckBoxClick(checkbox) {

                    var atleastOneCheckBoxUnchecked = false;

                    var gridView = document.getElementById("GridView1");

                    // Loop through each data row.
                    for (i = 1; i < gridView.rows.length; i++) {

                        //Δηλαδή αν κάποιο από τα check boxes είναι unchecked.
                        if (gridView.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked == false) {
                            atleastOneCheckBoxUnchecked = true;
                            break;
                        }
                    }

                    gridView.rows[0].cells[0].getElementsByTagName("INPUT")[0].checked = !atleastOneCheckBoxUnchecked;
                }
            </script>



        </div>

    </form>
</body>
</html>
