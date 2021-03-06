USE [master]
GO
/****** Object:  Database [QuanLyNhaSach]    Script Date: 6/5/2018 10:58:36 AM ******/
CREATE DATABASE [QuanLyNhaSach]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyNhaSach', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QuanLyNhaSach.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyNhaSach_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QuanLyNhaSach_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyNhaSach] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaSach].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaSach] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaSach] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyNhaSach] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaSach] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaSach] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaSach] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyNhaSach] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyNhaSach', N'ON'
GO
USE [QuanLyNhaSach]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) 
RETURNS NVARCHAR(4000) 
AS 
BEGIN 
	IF @strInput IS NULL 
		RETURN @strInput 
	IF @strInput = '' 
		RETURN @strInput 
	DECLARE @RT NVARCHAR(4000) 
	DECLARE @SIGN_CHARS NCHAR(136) 
	DECLARE @UNSIGN_CHARS NCHAR (136) 
	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208)
	SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
	DECLARE @COUNTER int 
	DECLARE @COUNTER1 int 
	SET @COUNTER = 1 
	WHILE (@COUNTER <=LEN(@strInput)) 
	BEGIN 
		SET @COUNTER1 = 1 
		WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
		BEGIN 
			IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
			BEGIN 
				IF @COUNTER=1 
					SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
				ELSE 
					SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
					BREAK 
			END 
				SET @COUNTER1 = @COUNTER1 +1 
		END 
		SET @COUNTER = @COUNTER +1 
	END 
	SET @strInput = replace(@strInput,' ','-') 
	RETURN @strInput 
END

GO
/****** Object:  Table [dbo].[BAOCAOCONGNO]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAOCAOCONGNO](
	[Thang] [int] NOT NULL,
	[Nam] [int] NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[NoDau] [float] NOT NULL,
	[PhatSinh] [float] NOT NULL,
	[NoCuoi] [float] NOT NULL,
 CONSTRAINT [PK_CTBAOCAONO] PRIMARY KEY CLUSTERED 
(
	[Thang] ASC,
	[Nam] ASC,
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BAOCAOTON]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAOCAOTON](
	[Thang] [int] NOT NULL,
	[Nam] [int] NOT NULL,
	[MaSach] [int] NOT NULL,
	[TonDau] [int] NOT NULL,
	[PhatSinh] [int] NOT NULL,
	[TonCuoi] [int] NOT NULL,
 CONSTRAINT [PK_ReportCountInfo] PRIMARY KEY CLUSTERED 
(
	[Thang] ASC,
	[Nam] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CT_HOADON]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_HOADON](
	[SoHoaDon] [int] NOT NULL,
	[MaSach] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGiaBan] [float] NOT NULL,
	[ThanhTien] [float] NULL,
 CONSTRAINT [PK_CTHD] PRIMARY KEY CLUSTERED 
(
	[SoHoaDon] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CT_PHIEUNHAPSACH]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_PHIEUNHAPSACH](
	[SoPhieuNhap] [int] NOT NULL,
	[MaSach] [int] NOT NULL,
	[SoLuongNhap] [int] NOT NULL,
	[DonGiaNhap] [float] NOT NULL,
	[ThanhTien] [float] NOT NULL,
 CONSTRAINT [PK_CTPHIEUNHAPSACH] PRIMARY KEY CLUSTERED 
(
	[SoPhieuNhap] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CT_TACGIA]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_TACGIA](
	[MaDauSach] [int] NOT NULL,
	[MaTacGia] [int] NOT NULL,
 CONSTRAINT [PK_CTTACGIA] PRIMARY KEY CLUSTERED 
(
	[MaDauSach] ASC,
	[MaTacGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DAUSACH]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DAUSACH](
	[MaDauSach] [int] IDENTITY(1,1) NOT NULL,
	[TenDauSach] [nvarchar](100) NOT NULL,
	[MaTheLoai] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDauSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[SoHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[NgayLap] [date] NOT NULL,
	[TongTien] [float] NOT NULL,
	[ThanhToan] [float] NOT NULL,
	[ConLai] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](100) NOT NULL,
	[DiaChi] [nvarchar](200) NOT NULL,
	[SoDienThoai] [varchar](11) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[SoTienNo] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NGUOIDUNG]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NGUOIDUNG](
	[TenDangNhap] [varchar](100) NOT NULL DEFAULT (''),
	[TenHienThi] [nvarchar](100) NULL,
	[MatKhau] [varchar](100) NOT NULL DEFAULT (''),
	[LoaiTaiKhoan] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PHIEUNHAPSACH]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUNHAPSACH](
	[SoPhieuNhap] [int] IDENTITY(1,1) NOT NULL,
	[NgayLap] [date] NOT NULL,
	[TongTien] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[SoPhieuNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHIEUTHUTIEN]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUTHUTIEN](
	[SoPhieuThu] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[NgayLap] [date] NOT NULL,
	[SoTienThu] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SoPhieuThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SACH]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SACH](
	[MaSach] [int] IDENTITY(1,1) NOT NULL,
	[MaDauSach] [int] NOT NULL,
	[NhaXuatBan] [nvarchar](100) NOT NULL,
	[NamXuatBan] [int] NOT NULL,
	[SoLuongTon] [int] NOT NULL,
	[DonGiaNhap] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TACGIA]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TACGIA](
	[MaTacGia] [int] IDENTITY(1,1) NOT NULL,
	[TenTacGia] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTacGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THAMSO]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[THAMSO](
	[TenThamSo] [varchar](100) NOT NULL,
	[GiaTri] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[TenThamSo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[THELOAISACH]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THELOAISACH](
	[MaTheLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenTheLoai] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (1, 6)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (2, 8)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (3, 9)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (4, 10)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (6, 5)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (7, 2)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (8, 1)
INSERT [dbo].[CT_TACGIA] ([MaDauSach], [MaTacGia]) VALUES (10, 4)
SET IDENTITY_INSERT [dbo].[DAUSACH] ON 

INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (1, N'Ngày xưa có một con bò', 3)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (2, N'Khéo ăn khéo nói sẽ có được thiên hạ ', 2)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (3, N'7 thói quen hiệu quả', 3)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (4, N'Người nam châm ', 3)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (6, N'Lối sống tối giản của người Nhật', 3)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (7, N'Tuổi trẻ đáng giá bao nhiêu ', 3)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (8, N'Tôi là Beto', 1)
INSERT [dbo].[DAUSACH] ([MaDauSach], [TenDauSach], [MaTheLoai]) VALUES (10, N'Trên đường băng', 3)
SET IDENTITY_INSERT [dbo].[DAUSACH] OFF
INSERT [dbo].[NGUOIDUNG] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'admin', N'admin', N'admin', 0)
SET IDENTITY_INSERT [dbo].[TACGIA] ON 

INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (1, N'Nguyễn Nhật Ánh ')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (2, N'Rosie Nguyễn ')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (3, N'Dale Carnegie')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (4, N'Tony buổi sáng ')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (5, N'Sasaki Fumio')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (6, N'Camilo Cruz')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (7, N'Stephen R.Covey')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (8, N'Trác Nhã ')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (9, N'Thomas L.Friedman')
INSERT [dbo].[TACGIA] ([MaTacGia], [TenTacGia]) VALUES (10, N'Jack Canfield')
SET IDENTITY_INSERT [dbo].[TACGIA] OFF
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'ApDungQD4 ', 1)
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'SoLuongNhapToiThieu ', 150)
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'SoLuongTonToiDa', 300)
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'SoLuongTonToiThieu', 20)
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'SoTienNoToiDa', 20)
INSERT [dbo].[THAMSO] ([TenThamSo], [GiaTri]) VALUES (N'TiLeTinhDonGiaBan', 1.05)
SET IDENTITY_INSERT [dbo].[THELOAISACH] ON 

INSERT [dbo].[THELOAISACH] ([MaTheLoai], [TenTheLoai]) VALUES (1, N'Sách thiếu nhi ')
INSERT [dbo].[THELOAISACH] ([MaTheLoai], [TenTheLoai]) VALUES (2, N'Sách kinh tế')
INSERT [dbo].[THELOAISACH] ([MaTheLoai], [TenTheLoai]) VALUES (3, N'Sách Kỹ năng sống')
INSERT [dbo].[THELOAISACH] ([MaTheLoai], [TenTheLoai]) VALUES (4, N'Sách học ngoại ngữ')
SET IDENTITY_INSERT [dbo].[THELOAISACH] OFF
ALTER TABLE [dbo].[BAOCAOCONGNO] ADD  DEFAULT ((0)) FOR [NoDau]
GO
ALTER TABLE [dbo].[BAOCAOCONGNO] ADD  DEFAULT ((0)) FOR [PhatSinh]
GO
ALTER TABLE [dbo].[BAOCAOCONGNO] ADD  DEFAULT ((0)) FOR [NoCuoi]
GO
ALTER TABLE [dbo].[BAOCAOTON] ADD  DEFAULT (datepart(month,getdate())) FOR [Thang]
GO
ALTER TABLE [dbo].[BAOCAOTON] ADD  DEFAULT (datepart(year,getdate())) FOR [Nam]
GO
ALTER TABLE [dbo].[BAOCAOTON] ADD  DEFAULT ((0)) FOR [TonDau]
GO
ALTER TABLE [dbo].[BAOCAOTON] ADD  DEFAULT ((0)) FOR [PhatSinh]
GO
ALTER TABLE [dbo].[BAOCAOTON] ADD  DEFAULT ((0)) FOR [TonCuoi]
GO
ALTER TABLE [dbo].[CT_HOADON] ADD  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[CT_HOADON] ADD  DEFAULT ((0)) FOR [DonGiaBan]
GO
ALTER TABLE [dbo].[CT_HOADON] ADD  DEFAULT ((0)) FOR [ThanhTien]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAPSACH] ADD  DEFAULT ((0)) FOR [SoLuongNhap]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAPSACH] ADD  DEFAULT ((0)) FOR [DonGiaNhap]
GO
ALTER TABLE [dbo].[CT_PHIEUNHAPSACH] ADD  DEFAULT ((0)) FOR [ThanhTien]
GO
ALTER TABLE [dbo].[HOADON] ADD  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[HOADON] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[HOADON] ADD  DEFAULT ((0)) FOR [ThanhToan]
GO
ALTER TABLE [dbo].[HOADON] ADD  DEFAULT ((0)) FOR [ConLai]
GO
ALTER TABLE [dbo].[KHACHHANG] ADD  DEFAULT (' ') FOR [TenKhachHang]
GO
ALTER TABLE [dbo].[KHACHHANG] ADD  DEFAULT (' ') FOR [DiaChi]
GO
ALTER TABLE [dbo].[KHACHHANG] ADD  DEFAULT (' ') FOR [SoDienThoai]
GO
ALTER TABLE [dbo].[KHACHHANG] ADD  DEFAULT (' ') FOR [Email]
GO
ALTER TABLE [dbo].[KHACHHANG] ADD  DEFAULT ((0)) FOR [SoTienNo]
GO
ALTER TABLE [dbo].[PHIEUNHAPSACH] ADD  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[PHIEUNHAPSACH] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN] ADD  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN] ADD  DEFAULT ((0)) FOR [SoTienThu]
GO
ALTER TABLE [dbo].[SACH] ADD  DEFAULT ((0)) FOR [SoLuongTon]
GO
ALTER TABLE [dbo].[SACH] ADD  DEFAULT ((0)) FOR [DonGiaNhap]
GO
ALTER TABLE [dbo].[BAOCAOCONGNO]  WITH CHECK ADD FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KHACHHANG] ([MaKhachHang])
GO
ALTER TABLE [dbo].[BAOCAOTON]  WITH CHECK ADD FOREIGN KEY([MaSach])
REFERENCES [dbo].[SACH] ([MaSach])
GO
ALTER TABLE [dbo].[CT_HOADON]  WITH CHECK ADD FOREIGN KEY([MaSach])
REFERENCES [dbo].[SACH] ([MaSach])
GO
ALTER TABLE [dbo].[CT_HOADON]  WITH CHECK ADD FOREIGN KEY([SoHoaDon])
REFERENCES [dbo].[HOADON] ([SoHoaDon])
GO
ALTER TABLE [dbo].[CT_PHIEUNHAPSACH]  WITH CHECK ADD FOREIGN KEY([MaSach])
REFERENCES [dbo].[SACH] ([MaSach])
GO
ALTER TABLE [dbo].[CT_PHIEUNHAPSACH]  WITH CHECK ADD FOREIGN KEY([SoPhieuNhap])
REFERENCES [dbo].[PHIEUNHAPSACH] ([SoPhieuNhap])
GO
ALTER TABLE [dbo].[CT_TACGIA]  WITH CHECK ADD FOREIGN KEY([MaDauSach])
REFERENCES [dbo].[DAUSACH] ([MaDauSach])
GO
ALTER TABLE [dbo].[CT_TACGIA]  WITH CHECK ADD FOREIGN KEY([MaTacGia])
REFERENCES [dbo].[TACGIA] ([MaTacGia])
GO
ALTER TABLE [dbo].[DAUSACH]  WITH CHECK ADD FOREIGN KEY([MaTheLoai])
REFERENCES [dbo].[THELOAISACH] ([MaTheLoai])
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KHACHHANG] ([MaKhachHang])
GO
ALTER TABLE [dbo].[PHIEUTHUTIEN]  WITH CHECK ADD FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KHACHHANG] ([MaKhachHang])
GO
ALTER TABLE [dbo].[SACH]  WITH CHECK ADD FOREIGN KEY([MaDauSach])
REFERENCES [dbo].[DAUSACH] ([MaDauSach])
GO
ALTER TABLE [dbo].[BAOCAOTON]  WITH CHECK ADD CHECK  (([Nam]<>(0)))
GO
ALTER TABLE [dbo].[BAOCAOTON]  WITH CHECK ADD CHECK  (([Thang]>=(1) AND [Thang]<=(12)))
GO
/****** Object:  StoredProcedure [dbo].[USP_AddAuthor]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddAuthor]
@name NVARCHAR(100)
AS
BEGIN
INSERT TACGIA(TenTacGia) VALUES (@name)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_AddAuthorInfo]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddAuthorInfo]
@idAuthor INT
AS
BEGIN
	DECLARE @idBookTitle INT
	SELECT @idBookTitle=MAX(MaDauSach) FROM DAUSACH
	INSERT CT_TACGIA(MaDauSach,MaTacGia)VALUES(@idBookTitle,@idAuthor)
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_AddAuthorInfoByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddAuthorInfoByBookTitleID]
@id INT,
@idAuthor INT
AS
BEGIN
	INSERT CT_TACGIA(MaDauSach,MaTacGia)VALUES(@id,@idAuthor)
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_AddBook]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddBook]
@idBookTitle INT,
@publishCompany NVARCHAR(100),
@publishYear INT
AS
BEGIN
	INSERT SACH(MaDauSach,NhaXuatBan,NamXuatBan,SoLuongTon,DonGiaNhap)VALUES(
	@idBookTitle,
	@publishCompany,
	@publishYear,
	0,
	0
	)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_AddBookTitle]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddBookTitle]
@name NVARCHAR(100),
@idCategory INT
AS
BEGIN
	INSERT DAUSACH(TenDauSach,MaTheLoai)VALUES(@name,@idCategory)
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_AddCategory]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddCategory]
@name NVARCHAR(100)
AS
BEGIN
INSERT THELOAISACH(TenTheLoai) VALUES (@name)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_AddCustomer]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_AddCustomer]
@name NVARCHAR(100),
@address NVARCHAR(100),
@phoneNumber VARCHAR(100),
@email VARCHAR(100),
@owe FLOAT
AS
BEGIN
	INSERT KHACHHANG(TenKhachHang,DiaChi,SoDienThoai,Email,SoTienNo) VALUES(
	@name,
	@address,
	@phoneNumber,
	@email,
	@owe
	)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName VARCHAR(100)
AS
BEGIN
	SELECT TenDangNhap as userName,TenHienThi as displayName,MatKhau as passWord,LoaiTaiKhoan as type FROM NGUOIDUNG WHERE TenDangNhap=@userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAuthorsByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAuthorsByBookTitleID]
@id INT
AS 
BEGIN
	SELECT t.MaTacGia as id,t.TenTacGia as name FROM CT_TACGIA ct,TACGIA t WHERE ct.MaDauSach=@id and ct.MaTacGia=t.MaTacGia
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetBookTitleByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetBookTitleByBookTitleID]
@id INT
AS 
BEGIN
	SELECT MaDauSach as id,TenDauSach as name,MaTheLoai as idCategory FROM DAUSACH WHERE MaDauSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetCategoryBookByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetCategoryBookByBookTitleID]
@id INT
AS
BEGIN
	SELECT th.MaTheLoai as id,th.TenTheLoai as name FROM THELOAISACH th,DAUSACH d WHERE d.MaDauSach=@id AND d.MaTheLoai=th.MaTheLoai
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetCheck]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetCheck]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='ApDungQD4'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetCountVersionByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetCountVersionByBookTitleID]
@id INT
AS
BEGIN
	SELECT COUNT(SACH.MaSach) as countVersion
	FROM SACH
	WHERE SACH.MaDauSach= @id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetCustomerByCustomerID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetCustomerByCustomerID]
@id INT
AS
BEGIN
	SELECT  MaKhachHang as id,TenKhachHang name,DiaChi as address,SoDienThoai as phoneNumber,Email as email,SoTienNo as owe FROM KHACHHANG WHERE MaKhachHang=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListAccount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListAccount]
AS
BEGIN
	SELECT TenDangNhap as userName,TenHienThi as displayName,MatKhau as passWord,LoaiTaiKhoan as type
	FROM NGUOIDUNG 
	WHERE LoaiTaiKhoan=1
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListAuthor]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListAuthor]
AS
BEGIN
SELECT MaTacGia as id,TenTacGia as name FROM TACGIA 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByCustomerID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByCustomerID]
@id INT
AS
BEGIN
	SELECT SoHoaDon as idBill, HOADON.MaKhachHang as idCustomer,TenKhachHang as nameCustomer,NgayLap as date, TongTien as value
	FROM HOADON , KHACHHANG
	WHERE HOADON.MaKhachHang=@id and HOADON.MaKhachHang=KHACHHANG.MaKhachHang
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByTime]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByTime]
@month INT,
@year INT
AS
BEGIN
	SELECT SoHoaDon as iD,MaKhachHang as idCustomer,NgayLap as date, TongTien as value, ConLai as owe
	FROM HOADON 
	WHERE MONTH(NgayLap)=@month AND YEAR(NgayLap)=@year 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillInfoByTime]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillInfoByTime]
@month INT,
@year INT
AS
BEGIN
	SELECT h.SoHoaDon as idBill,ch.MaSach as idBook,ch.SoLuong as count,ch.DonGiaBan as priceOut
	FROM HOADON h,CT_HOADON ch
	WHERE h.SoHoaDon=ch.SoHoaDon AND MONTH(h.NgayLap)=@month AND YEAR(h.NgayLap)=@year 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBook]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBook]
AS
BEGIN
	SELECT s.MaSach as id,s.MaDauSach as idBookTitle,d.TenDauSach as name,s.NhaXuatBan as publishCompany,s.NamXuatBan as publishYear,s.SoLuongTon as count,s.DonGiaNhap as priceIn
	FROM SACH s, DAUSACH d
	WHERE S.MaDauSach=D.MaDauSach
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBookTitle]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBookTitle]
AS 
BEGIN
	SELECT MaDauSach as id,TenDauSach as name,MaTheLoai as idCategory FROM DAUSACH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListCategory]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListCategory]
AS
BEGIN
SELECT MaTheLoai as id,TenTheLoai as name FROM THELOAISACH 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListCollectMoneyByTime]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[USP_GetListCollectMoneyByTime]
@month INT,
@year INT
AS
BEGIN
	SELECT SoPhieuThu as iD,MaKhachHang as idCustomer,NgayLap as date, SoTienThu as money
	FROM PHIEUTHUTIEN 
	WHERE MONTH(NgayLap)=@month AND YEAR(NgayLap)=@year 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListCustomer]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListCustomer]
AS
BEGIN
SELECT MaKhachHang as id,TenKhachHang name,DiaChi as address,SoDienThoai as phoneNumber,Email as email,SoTienNo as owe FROM KHACHHANG
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListImportBookInfoByTime]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListImportBookInfoByTime]
@month INT,
@year INT
AS
BEGIN
	SELECT p.SoPhieuNhap as idImportBook,cp.MaSach as idBook,cp.SoLuongNhap as count,cp.DonGiaNhap as priceIn 
	FROM PHIEUNHAPSACH p,CT_PHIEUNHAPSACH cp 
	WHERE p.SoPhieuNhap=cp.SoPhieuNhap AND MONTH(p.NgayLap)=@month AND YEAR(p.NgayLap)=@year 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListNameAuthorByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListNameAuthorByBookTitleID]
@id INT
AS
BEGIN
	SELECT t.TenTacGia as author
	FROM TACGIA t, CT_TACGIA ct,DAUSACH d
	WHERE t.MaTacGia=ct.MaTacGia and d.MaDauSach=ct.MaDauSach and d.MaDauSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetMaxCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetMaxCount]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='SoLuongTonToiDa'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetMaxOwe]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetMaxOwe]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='SoTienNoToiDa'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetMinCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetMinCount]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='SoLuongTonToiThieu'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetMinImport]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetMinImport]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='SoLuongNhapToiThieu'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDBill]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNewIDBill]
AS
BEGIN
	SELECT MAX(SoHoaDon)+1 FROM HOADON
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDBook]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNewIDBook]
AS
BEGIN
	SELECT MAX(MaSach)+1 FROM SACH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDBookTitle]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNewIDBookTitle]
AS
BEGIN
	SELECT MAX(MaDauSach)+1 FROM DAUSACH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDCollectMoney]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_GetNewIDCollectMoney]
AS
BEGIN
	SELECT MAX(SoPhieuThu)+1 FROM PHIEUTHUTIEN
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDCustomer]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNewIDCustomer]
AS
BEGIN
	SELECT MAX(MaKhachHang+1) FROM KHACHHANG
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewIDImportBook]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNewIDImportBook]
AS
BEGIN
	SELECT MAX(SoPhieuNhap)+1 FROM PHIEUNHAPSACH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetPercentPrice]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetPercentPrice]
AS
BEGIN
	SELECT GiaTri FROM THAMSO WHERE TenThamSo='TiLeTinhDonGiaBan'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetPublishingByBookID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetPublishingByBookID]
@id INT
AS
BEGIN
	SELECT NhaXuatBan as publishCompany,NamXuatBan as publishYear
	FROM SACH
	WHERE MaSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetPublishingByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetPublishingByBookTitleID]
@id INT
AS
BEGIN
	SELECT NhaXuatBan as publishCompany,NamXuatBan as publishYear FROM SACH WHERE MaDauSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetReportCountByTime]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetReportCountByTime]
@month INT,
@year INT
AS
BEGIN
	SELECT Thang as month, Nam as year, MaSach as idBook, TonDau as firstCount, PhatSinh as addCount, TonCuoi as lastCount
	FROM BAOCAOTON
	WHERE Thang=@month AND Nam=@year
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetReportCountByTimeAndBookID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetReportCountByTimeAndBookID]
@month INT,
@year INT,
@idBook INT
AS
BEGIN
	SELECT Thang as month, Nam as year, MaSach as idBook, TonDau as firstCount, PhatSinh as addCount, TonCuoi as lastCount
	FROM BAOCAOTON
	WHERE Thang=@month and Nam=@year and MaSach=@idBook
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetReportOwe]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetReportOwe]
@month INT,
@year INT
AS
BEGIN
	SELECT Thang as month, Nam as year, MaKhachHang as idCustomer, NoDau as firstOwe, PhatSinh as addOwe, NoCuoi as lastOwe
	FROM BAOCAOCONGNO
	WHERE Thang=@month AND Nam=@year
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetReportOweByTimeAndCustomerID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetReportOweByTimeAndCustomerID]
@month INT,
@year INT,
@idCustomer INT
AS
BEGIN
	SELECT Thang as month, Nam as year, MaKhachHang as idCustomer, NoDau as firstOwe, PhatSinh as addOwe, NoCuoi as lastOwe
	FROM BAOCAOCONGNO
	WHERE Thang=@month and Nam=@year and MaKhachHang=@idCustomer
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTotalCountByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetTotalCountByBookTitleID]
@id INT
AS
BEGIN
	SELECT SUM(SACH.SoLuongTon) as totalCount
	FROM SACH
	WHERE SACH.MaDauSach= @id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertAccount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertAccount] 
@userName VARCHAR(100),
@displayName NVARCHAR(100),
@passWord VARCHAR(100)
AS
BEGIN
	INSERT NGUOIDUNG VALUES( @userName,@displayName , @passWord,1)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfoIntoDatabase]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBillInfoIntoDatabase]
	@idBook INT ,
	@count INT ,
	@priceOut FLOAT,
	@totalPrice FLOAT
AS
BEGIN
	DECLARE @idBill INT
	SELECT @idBill=MAX(SoHoaDon) FROM HOADON
	INSERT CT_HOADON (SoHoaDon,MaSach ,SoLuong ,DonGiaBan ,	ThanhTien )VALUES
	(
		@idBill,
		@idBook  ,
		@count  ,
		@priceOut ,
		@totalPrice 
	)
	UPDATE SACH SET SoLuongTon=SoLuongTon-@count WHERE MaSach=@idBook
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillIntoDatabase]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBillIntoDatabase]
	@idCustomer INT ,
	@date DATE,
	@totalMoney FLOAT,
	@receiveMoney FLOAT,
	@moneyOwe FLOAT
AS
BEGIN
	INSERT HOADON ( MaKhachHang,NgayLap,TongTien,ThanhToan,ConLai )VALUES
	(
		@idCustomer,
		@date,
		@totalMoney,
		@receiveMoney,
		@moneyOwe
	)
	IF(@moneyOwe >0)
		UPDATE KHACHHANG SET SoTienNo=SoTienNo+@moneyOwe WHERE MaKhachHang=@idCustomer
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertCollectMoneyIntoDatabase]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertCollectMoneyIntoDatabase]
@idCustomer INT,
@date DATE,
@money FLOAT
AS
BEGIN
	INSERT PHIEUTHUTIEN(MaKhachHang,NgayLap,SoTienThu)VALUES
	(
		@idCustomer,
		@date,
		@money
	)
	UPDATE KHACHHANG SET SoTienNo=SoTienNo-@money WHERE MaKhachHang=@idCustomer
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertImportBookInfoIntoDatabase]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertImportBookInfoIntoDatabase]
@idBook INT,
@count INT,
@priceIn FLOAT,
@money FLOAT
AS
BEGIN
	DECLARE @importBookID INT
	SELECT @importBookID=MAX(SoPhieuNhap) FROM PHIEUNHAPSACH
	IF((SELECT count(*) FROM CT_PHIEUNHAPSACH WHERE SoPhieuNhap=@importBookID AND MaSach=@idBook)=0)
	BEGIN
		INSERT CT_PHIEUNHAPSACH(SoPhieuNhap,MaSach,	SoLuongNhap ,DonGiaNhap,ThanhTien)VALUES(
			@importBookID,
			@idBook,
			@count,
			@priceIn,
			@money
			)

	END
	ELSE
	BEGIN
		UPDATE CT_PHIEUNHAPSACH
		SET	SoLuongNhap=SoLuongNhap+ @count,
			DonGiaNhap= @priceIn,
			ThanhTien=ThanhTien+ @money
		WHERE SoPhieuNhap= @importBookID and MaSach=@idBook
	END
	UPDATE SACH SET DonGiaNhap=@priceIn, SoLuongTon=SoLuongTon+@count WHERE MaSach=@idBook

END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertImportBookIntoDatabase]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertImportBookIntoDatabase]
@date DATE
AS
BEGIN
	INSERT PHIEUNHAPSACH(NgayLap,TongTien) VALUES (@date,0)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertReportCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertReportCount] 
@month INT,
@year INT, 
@idBook INT, 
@firstCount INT, 
@addCount INT, 
@lastCount INT
AS
BEGIN
	INSERT BAOCAOTON VALUES
	(
		@month ,
	@year , 
	@idBook , 
	@firstCount , 
	@addCount , 
	@lastCount
	)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertReportOwe]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertReportOwe] 
@month INT,
@year INT, 
@idCustomer INT, 
@firstOwe INT, 
@addOwe INT,
@lastOwe INT
AS
BEGIN
	INSERT BAOCAOCONGNO VALUES
	(
		@month ,
	@year , 
	@idCustomer , 
	@firstOwe , 
	@addOwe , 
	@lastOwe
	)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_LoadListBillInfo]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_LoadListBillInfo]
@id INT
AS
BEGIN
	SELECT ct.MaSach as id,d.MaDauSach AS idBookTitle,d.TenDauSach as name, th.TenTheLoai as category,ct.SoLuong as count,ct.DonGiaBan as priceOut
	FROM CT_HOADON ct, SACH s, DAUSACH d,THELOAISACH th
	WHERE SoHoaDon=@id AND ct.MaSach =s.MaSach and s.MaDauSach=d.MaDauSach and d.MaTheLoai=th.MaTheLoai
END

GO
/****** Object:  StoredProcedure [dbo].[USP_LoadListBookTitle]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_LoadListBookTitle]
AS
BEGIN
	SELECT d.MaDauSach as id,d.TenDauSach as name,th.TenTheLoai as category
	FROM DAUSACH d, THELOAISACH th
	WHERE d.MaTheLoai=th.MaTheLoai
END

GO
/****** Object:  StoredProcedure [dbo].[USP_LoadReportCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_LoadReportCount]
@month INT,
@year INT
AS
BEGIN
	SELECT MaSach as idBook,TonDau as firstCount, PhatSinh as addCount, TonCuoi as lastCount
	FROM BAOCAOTON
	WHERE Thang=@month AND Nam=@year
END

GO
/****** Object:  StoredProcedure [dbo].[USP_LoadReportOwe]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_LoadReportOwe]
@month INT,
@year INT
AS
BEGIN
	SELECT MaKhachHang as idCustomer,NoDau as firstOwe, PhatSinh as addOwe, NoCuoi as lastOwe
	FROM BAOCAOCONGNO
	WHERE Thang=@month AND Nam=@year
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName VARCHAR(100),
@passWord VARCHAR(100)
AS
BEGIN
SELECT * FROM dbo.NGUOIDUNG WHERE @userName=TenDangNhap AND @passWord=MatKhau
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveAccountByUserName]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveAccountByUserName] 
@userName VARCHAR(100)
AS
BEGIN
	DELETE NGUOIDUNG WHERE TenDangNhap=@userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveAuthorByAuthorID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveAuthorByAuthorID]
@id INT
AS
BEGIN
DELETE TACGIA WHERE MaTacGia =@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveBookTitleByBookTitleID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveBookTitleByBookTitleID]
@id INT
AS
BEGIN
	DELETE CT_TACGIA WHERE MaDauSach=@id
	DELETE DAUSACH WHERE MaDauSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveCategoryByCategoryID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveCategoryByCategoryID]
@id INT
AS
BEGIN
DELETE THELOAISACH WHERE MaTheLoai =@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveCustomerByCustomerID]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveCustomerByCustomerID]
@id INT
AS
BEGIN
	DELETE KHACHHANG WHERE MaKhachHang= @id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RemoveReportCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_RemoveReportCount]
@month INT,
@year INT
AS
BEGIN
	DELETE BAOCAOTON WHERE Thang=@month and Nam=@year
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetCheck]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetCheck]
@check INT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@check WHERE TenThamSo='ApDungQD4'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetMaxCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetMaxCount]
@maxCount INT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@maxCount WHERE TenThamSo='SoLuongTonToiDa'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetMaxOwe]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetMaxOwe]
@maxOwe INT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@maxOwe WHERE TenThamSo='SoTienNoToiDa'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetMinCount]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetMinCount]
@minCount INT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@minCount WHERE TenThamSo='SoLuongTonToiThieu'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetMinImport]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetMinImport]
@minImport INT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@minImport WHERE TenThamSo='SoLuongNhapToiThieu'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SetPercentPrice]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SetPercentPrice]
@percentPrice FLOAT
AS
BEGIN
	UPDATE THAMSO SET GiaTri=@percentPrice WHERE TenThamSo='TiLeTinhDonGiaBan'
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccountByUserName]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccountByUserName] 
@userName VARCHAR(100),
@displayName NVARCHAR(100),
@passWord VARCHAR(100)
AS
BEGIN
	UPDATE NGUOIDUNG SET TenHienThi=@displayName , MatKhau=@passWord WHERE TenDangNhap=@userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAuthor]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAuthor]
@id INT,
@name NVARCHAR(100)
AS
BEGIN
UPDATE TACGIA SET TenTacGia=@name WHERE MaTacGia = @id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBookTitle]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateBookTitle]
@id INT,	
@name NVARCHAR(100),
@idCategory INT
AS
BEGIN
	UPDATE DAUSACH 
	SET TenDauSach=@name, MaTheLoai=@idCategory
	WHERE MaDauSach=@id

	DELETE CT_TACGIA WHERE MaDauSach=@id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateCategory]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateCategory]
@id INT,
@name NVARCHAR(100)
AS
BEGIN
UPDATE THELOAISACH SET TenTheLoai=@name WHERE MaTheLoai = @id
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateCustomer]    Script Date: 6/5/2018 10:58:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateCustomer]
@id INT,
@name NVARCHAR(100),
@address NVARCHAR(100),
@phoneNumber VARCHAR(100),
@email VARCHAR(100),
@owe FLOAT
AS
BEGIN
	UPDATE KHACHHANG 
	SET
		TenKhachHang=@name,
		DiaChi=@address,
		SoDienThoai=@phoneNumber,
		Email=@email,
		SoTienNo=@owe
	WHERE MaKhachHang=@id
END

GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaSach] SET  READ_WRITE 
GO
