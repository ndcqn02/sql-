create database trtrtr
go
use  trtrtr
go
create table SinhVien
( 
	Masv char(7) primary key,
	HoTen nvarchar(50),
	Passwork char(10),
	statusSV nvarchar(50),
	Dob datetime 
)

create table HocKy
( 
	MaHK char(7) primary key,
	TenHK char(7)
)
create table TKHK
(
	MaHK char(7) ,
	Masv char(7) primary key (MaHK,Masv) ,
	MaDk char(7),
	STCDK int,
	STCTL int,
	DTBC int,
	FOREIGN KEY (Masv) REFERENCES SinhVien(Masv),
	FOREIGN KEY (MaHK) REFERENCES HocKy(MaHK)
)


create table GiaoVien
( 
	MaGV char(7) primary key,
	HoTen nvarchar(50),
	CMND char(10)
)

create table HocPhan
( 
	MaHP char(7) primary key,
	TenHP char(7),
	SoTC int
)

create table LopHP
( 
	MaLHP char(7) primary key,
	MaHP char(7),
	MaHK char(7),
	MaGV char(7),
	SDDK int ,
	SSMax int,
	FOREIGN KEY (MaHK) REFERENCES HocKy(MaHK),
	FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV),
	FOREIGN KEY (MaHP) REFERENCES HocPhan(MaHP)
)

create table LHP_SV
( 
	MaLHP char(7) ,
	Masv char(7) primary key(MaLHP,Masv),
	DTKHP nvarchar(10),
	statusHP nvarchar(50),
	FOREIGN KEY (MaLHP) REFERENCES LopHP(MaLHP),
	FOREIGN KEY (Masv) REFERENCES SinhVien(Masv)

)

--- trigger
go
create or alter trigger them_xoa
on LHP_SV
after insert, update,delete
as
begin
	if not exists (select * from deleted)
	begin
		print N' May Insert'
		update LopHP
		set SDDK = SDDK + (select count(maSV) 
							from LHP_SV
							where LopHP.MaLHP = inserted.MaLHP)
		from LopHP 
		join inserted on inserted.MaLHP = LopHP.MaLHP
	end
	else if not exists (select * from inserted)
	begin
		print N' May delete'
		update LopHP
		set SDDK = SDDK - (select count(maSV) 
							from LHP_SV
							where LopHP.MaLHP = deleted.MaLHP)
		from LopHP 
		join deleted on deleted.MaLHP = LopHP.MaLHP
	end
end


select * from LopHP

insert into SinhVien
values ('SV1',N'Nguyen Duc Cuong','mamay','tot',2021-10-10),
		('SV2',N'Nguyen','mamay','tot',2021-10-11)

insert into LopHP
values ('LHP1',null,null,null,202,300),
		('LHP2',null,null,null,100,1500)
-------------------------------
 -- demo

insert into LHP_SV
values ('LHP1','SV1',null,null),
		('LHP1','SV2',null,null)

delete from LHP_SV
where MaLHP = 'LHP1' and Masv = 'SV2'

select * from LopHP

--

