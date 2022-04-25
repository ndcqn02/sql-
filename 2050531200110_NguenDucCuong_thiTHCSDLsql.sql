create database Xe
go
use  Xe
go
create table tblXe
( 
	idXe char(7) not null primary key,
	LoaiXe nvarchar(20),
	BienSo char(10),
	tongSoCho int 
)
create table tblChuyenXe
( 
	idChuyenXe char(7) not null primary key,
	idXe char(7),
	idDriver char(7),
	idTuyen  char(7),
	ngayKhoiHanh datetime,
	soKhachDaDatCho int,
	soGheConTrong int,
	FOREIGN KEY (idXe) REFERENCES tblXe(idXe)

)

create table tblKhachDatCho
( 
	idDatCho int not null primary key,
	idChuyenXe char(7),
	CMND char(9),
	Tel char(11),
	ngayThanhToan datetime,
	FOREIGN KEY (idChuyenXe) REFERENCES tblChuyenXe(idChuyenXe)
)

insert into tblXe
values ('X01',null,null,200),
		('X02',null,null,200)
--- chen du lieu
insert into tblChuyenXe
values ('CX1','X01','DR01',null,2021-10-11,150,40),
		('CX2','X02','DR02',null,2021-10-11,200,50)

insert into tblKhachDatCho
values (1,'CX1',null,null,null),
		(2,'CX1',null,null,null)


--- trigger
go
create or alter trigger tg_KhachDC
on tblKhachDatCho
after insert, update,delete
as
begin
	if not exists (select * from deleted)
	begin
		print N' Ban Insert'
		update tblChuyenXe
		set soKhachDaDatCho = tblChuyenXe.tongSoCho + (select count(idDatCho) 
							from inserted
							where tblChuyenXe.idChuyenXe = inserted.idChuyenXe)
		from tblChuyenXe 
		join inserted on inserted.idChuyenXe = tblChuyenXe.idChuyenXe
		join tblChuyenXe.idXe
		
	end
	else if not exists (select * from inserted)
	begin
		print N' Ban delete'
		update tblChuyenXe
		set soKhachDaDatCho = soKhachDaDatCho - (select count(idDatCho) 
							from deleted
							where tblChuyenXe.idChuyenXe = deleted.idChuyenXe)
		from tblChuyenXe 
		join deleted on deleted.idChuyenXe = tblChuyenXe.idChuyenXe
	end
end



--- chen
insert into tblKhachDatCho
values (3,'CX2',null,null,null)

select * from tblChuyenXe

--- xoa
delete from tblKhachDatCho
where idDatCho = 3 

select * from tblChuyenXe


--- cau 2
go
create or alter trigger tg_KhachDC
on tblKhachDatCho
after insert, update,delete
as
begin
	if not exists (select * from deleted)
	begin
		print N' Ban Insert'
		update tblChuyenXe
		set soGheConTrong = ton + (select count(idDatCho) 
							from inserted
							where tblChuyenXe.idChuyenXe = inserted.idChuyenXe)
		from tblChuyenXe 
		join inserted on inserted.idChuyenXe = tblChuyenXe.idChuyenXe
	end
	else if not exists (select * from inserted)
	begin
		print N' Ban delete'
		update tblChuyenXe
		set soKhachDaDatCho = tongso - (select count(idDatCho) 
							from deleted
							where tblChuyenXe.idChuyenXe = deleted.idChuyenXe)
		from tblChuyenXe 
		join deleted on deleted.idChuyenXe = tblChuyenXe.idChuyenXe
	end
end
