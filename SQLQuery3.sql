create database baidoxetudong
go
use baidoxetudong
go
create table Khu
(
  idkhu char(10) not null,
  tenkhu nvarchar(10) not null,
  tongSocho int not null,
  primary key (idkhu)
)
go
create table PhieuDoxe
(
  idPDX char(10) not null,
  taikhu char(10) not null
     constraint FK_PDX_63 foreign key (taikhu) references Khu(idkhu)
			on delete 
			 cascade
			on update 
			 cascade,
  Ngaygiovaobai date not null,
  bienSoxe nvarchar(10) not null,
  NgaygioRabai date not null,
  primary key (idPDX)
)
go
create table XeDangKyLauDai
(
  idXe char(10) not null,
  taiKhu char(10) not null
	constraint FK_XEDKLAUDAI_63 foreign key (taikhu) references Khu(idkhu)
			on delete 
				cascade
			on update 
				cascade,  
  bienso nvarchar(10) not null,
  loaiXe nvarchar(10) not null,
  NgayBatdau date  null default getdate(),
  SoThangQuyNam int not null,
  hinhthucThoigian nvarchar(10) not null,
  primary key (idXe)
)
go
insert into Khu
values ('K01_66','Khu A',100),
       ('K02_66','Khu B',78)

go
insert into PhieuDoxe
values('P1_66','K01_66','10/10/2016','92F194567','11/12/2016'),
       ('P2_66','K02_66','12/12/2020','92G134567','12/01/2021')
go
insert into XeDangKyLauDai
values('92-G1366','K01_66','92C199845',N'4 chỗ',default,6,N'Tháng'),
      ('92-f1266','K02_66','92D124567',N'16 chỗ',default,2,N'Tháng')

	  select * from PhieuDoxe