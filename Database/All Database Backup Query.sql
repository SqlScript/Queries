
Declare @Location nvarchar(256) = 'E:\Backup_DB_test\' -- set location for backup
declare @DatabaseName table(id INT IDENTITY NOT NULL PRIMARY KEY,name nvarchar(500))
insert into @DatabaseName
SELECT name  
FROM sys.databases

DECLARE @id int

SELECT @ID =1 

WHILE @ID <= (SELECT MAX(ID) FROM @DatabaseName)
BEGIN

declare @DatabseNAme nvarchar(256)
declare @DatabseNAmeMessage nvarchar(500)
select @DatabseNAme = name from @DatabaseName where id = @id
declare @Path  nvarchar(256) = @Location +  @DatabseNAme +'.bak'
BACKUP DATABASE @DatabseNAme
TO DISK = @Path
   WITH FORMAT,
      MEDIANAME = @DatabseNAme,
      NAME = @DatabseNAmeMessage
	  ,COMPRESSION -- comment this for uncompressed backup
	  ;



SET @ID = @ID + 1

END