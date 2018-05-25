﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhaSach.DTO
{
    public class ReportCount
    {
        private int month;
        private int year;
        public int Month { get => month; set => month = value; }
        public int Year { get => year; set => year = value; }

        public ReportCount(int month,int year)
        {
            this.Month = month;
            this.Year = year;
        }
        public ReportCount(DataRow row)
        {
            this.Month = (int)row["month"];
            this.Year =(int)row["year"];
        }
    }
}