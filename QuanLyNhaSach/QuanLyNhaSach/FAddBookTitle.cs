﻿using QuanLyNhaSach.DAO;
using QuanLyNhaSach.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyNhaSach
{
    public partial class FAddBookTitle : Form
    {
        public FAddBookTitle()
        {
            InitializeComponent();
            LoadForm();
        }
        #region Method
        public void LoadForm()
        {
            LoadCategoryIntoCombobox();
            LoadAuthorIntoCombobox();

            cbCategory.SelectedIndex = -1;
            cbCategory.SelectedIndexChanged += cbCategory_SelectedIndexChanged;

            cbAuthor.SelectedIndex = -1;
            cbAuthor.SelectedIndexChanged += cbAuthor_SelectedIndexChanged;
        }
        public void LoadCategoryIntoCombobox()
        {
            List<CategoryBook>list= CategoryBookDAO.Instance.GetListCategory();
            list.Add(new CategoryBook(-1, "Thêm"));
            cbCategory.DataSource = list;
            cbCategory.DisplayMember = "name";
        }
        public void LoadAuthorIntoCombobox()
        {
            List<Author> list = AuthorDAO.Instance.GetListAuthor();
            list.Add(new Author(-1, "Thêm"));
            cbAuthor.DataSource = list;
            cbAuthor.DisplayMember = "name";
        }
        public bool AddBookTitle(string name, int idCategory, List<int> authors)
        {
            return BookTitleDAO.Instance.AddBookTitle(name, idCategory, authors);
        }

        #endregion

        private event EventHandler updateForm;
        public event EventHandler UpdateForm
        {
            add { updateForm += value; }
            remove { updateForm -= value; }
        }
        #region Event
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void btnAddBookTitle_Click(object sender, EventArgs e)
        {
            try
            {
                if (txbBookTitle.Text == "")
                {
                    MessageBox.Show("Bạn chưa nhập tên sách !","Thông báo");
                    return;
                }

                if (cbCategory.SelectedItem == null)
                {
                    MessageBox.Show("Bạn chưa chọn thể loại sách !", "Thông báo");
                    return;
                }
                if (dtgvAuthor.RowCount == 0)
                {
                    MessageBox.Show("Bạn chưa nhập tác giả !", "Thông báo");
                    return;
                }
                string name = txbBookTitle.Text;
                int idCategory = (cbCategory.SelectedItem as CategoryBook).ID;
                List<int> authors = new List<int>();
                for (int i = 0; i < dtgvAuthor.Rows.Count; i++)
                {
                    authors.Add(Int32.Parse(dtgvAuthor.Rows[i].Cells["id"].Value.ToString()));
                }


                if (AddBookTitle(name, idCategory, authors))
                {
                    MessageBox.Show("Thêm sách thành công!", "Thông báo");
                    if (updateForm != null)
                    {
                        updateForm(this, new EventArgs());
                    }
                }
                else
                    MessageBox.Show("Thêm sách thất bại !", "Thông báo");
            }
            catch { MessageBox.Show("Tác vụ bị lỗi !", "Thông báo"); }
        }

        private void pbAddAuthor_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbAuthor.SelectedItem != null)
                {
                    Author author = cbAuthor.SelectedItem as Author;
                    for (int i = 0; i < dtgvAuthor.Rows.Count; i++)
                    {
                        if (Int32.Parse(dtgvAuthor.Rows[i].Cells["id"].Value.ToString()) == author.ID)
                            return;
                    }
                    dtgvAuthor.Rows.Add(author.ID, author.Name);
                }
            }
            catch { MessageBox.Show("Tác vụ bị lỗi !", "Thông báo"); }
        }

        private void pbRemoveAuthor_Click(object sender, EventArgs e)
        {
            try
            {
                if (dtgvAuthor.SelectedRows.Count > 0)
                {
                    dtgvAuthor.Rows.RemoveAt(dtgvAuthor.SelectedRows[0].Index);
                }
            }
            catch { MessageBox.Show("Tác vụ bị lỗi !", "Thông báo"); }
        }

        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if ((cbCategory.SelectedItem as CategoryBook).ID == -1)
                {
                    FAddCategory f = new FAddCategory();
                    f.UpdateForm += delegate (object _sender, EventArgs _e)
                    {
                        LoadCategoryIntoCombobox();
                    };
                    f.ShowDialog();
                }
            }
            catch { MessageBox.Show("Tác vụ bị lỗi !", "Thông báo"); }
        }

        private void cbAuthor_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if ((cbAuthor.SelectedItem as Author).ID == -1)
                {
                    FAddAuthor f = new FAddAuthor();
                    f.UpdateForm += delegate (object _sender, EventArgs _e)
                    {
                        LoadAuthorIntoCombobox();
                    };
                    f.ShowDialog();
                }
            }
            catch { MessageBox.Show("Tác vụ bị lỗi !", "Thông báo"); }
        }
        #endregion
    }
}
