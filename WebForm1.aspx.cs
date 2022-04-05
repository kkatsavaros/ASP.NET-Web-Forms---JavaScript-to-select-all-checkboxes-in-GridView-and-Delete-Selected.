using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace s02.JavaScriptConfirmOnGridviewDelete
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void Delete(string employeeIDs)
        {
            string cs = ConfigurationManager.ConnectionStrings["CustomersConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            //store procedure to delete Employees by id
            SqlCommand cmd = new SqlCommand("spDeleteEmployees", con); 
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter("@IDs", employeeIDs);
            cmd.Parameters.Add(parameter);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void lbDeleteSelected_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            foreach (GridViewRow gr in GridView1.Rows)
            {

                CheckBox cb = (CheckBox)gr.FindControl("CheckBox1");

                if (cb.Checked)
                {
                    // Γιαυτό μετατρέψαμε την στήλη id σε template field.
                    sb.Append(((Label)gr.FindControl("Label1")).Text + ","); // Παίρνω την id
                }
            }

            // Θα αφαιρέσουμε μόνο εάν χαρακτήρα.
            sb.Remove(sb.ToString().LastIndexOf(","), 1);

            Delete(sb.ToString()); // Την φτιάξαμε παραπάνω.

            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                LinkButton lb = (LinkButton)e.Row.FindControl("LinkButton1");

                lb.Attributes.Add("onclick", "return confirm('Are you sure to delete record with ID = " + DataBinder.Eval(e.Row.DataItem, "ID") + "');");

            }


        }
    }
}