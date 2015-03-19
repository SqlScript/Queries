declare 
@TableName NVARCHAR(50) = 'test'




DECLARE  @ProtdVars NVARCHAR(max),@PublicProps NVARCHAR(max), @CMDProps NVARCHAR(max), @InsertStmt NVARCHAR(max), @UpdateStmt NVARCHAR(max)
Declare @MyString nvarchar(max), @NewLineChar AS CHAR(2) 
SET @NewLineChar = Char(13) + CHAR(10)
DECLARE @ColName NVARCHAR(20), @ColType NVARCHAR(10)
DECLARE @Value nvarchar(50)
SET @ProtdVars = ''
SET @PublicProps = ''
SET @CMDProps = ''
SET @InsertStmt = ''
SET @UpdateStmt = ''

BEGIN
      
      DEALLOCATE c1
      DECLARE c1 CURSOR FOR 
      SELECT c.name ColumnName, t.name ColumnType
      FROM sys.columns AS c
      JOIN sys.types AS t ON c.user_type_id=t.user_type_id
      WHERE 
      OBJECT_name(c.object_id) = @TableName
  OPEN c1
      FETCH NEXT FROM c1 INTO @ColName, @ColType
      WHILE @@FETCH_STATUS =0
      BEGIN
            SET @MyString = ''
            
              IF @ColType= 'bigint' 
            BEGIN
                  SET @ColType = 'Int'
                  SET @Value = 'NullHandler.Int32(_'+@ColName+')'
                  SET @PublicProps = @PublicProps + 'public long '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private long _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'int' OR @ColType = 'smallint' OR @ColType = 'tinyint'
            BEGIN
                  SET @ColType = 'Int'
                  SET @Value = 'NullHandler.Int32(_'+@ColName+')'
                  SET @PublicProps = @PublicProps + 'public int '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private int _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'decimal'
            BEGIN
                  SET @ColType = 'Decimal'
                  SET @Value = 'NullHandler.'+@ColName+'(_'+@ColName+')'
                  SET @PublicProps = @PublicProps + 'public decimal '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private decimal _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'bit'
            BEGIN
                  SET @ColType = 'Bit'
                  SET @Value = '_'+@ColName
                  SET @PublicProps = @PublicProps + 'public bool '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private bool _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'nvarchar' OR @ColType= 'varchar'
            BEGIN
                  SET @ColType = 'NVarChar'
                  SET @Value = '_'+@ColName
                  SET @PublicProps = @PublicProps + 'public string '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private string _'+ @ColName + ';' + @NewLineChar
            END
            IF @ColType= 'ntext' OR @ColType= 'text'
            BEGIN
                  SET @ColType = 'NText'
                  SET @Value = '_'+@ColName
                  SET @PublicProps = @PublicProps + 'public string '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private string _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'datetime' OR  @ColType= 'timestamp'
            BEGIN
                  SET @ColType = 'DateTime'
                  SET @Value = 'NullHandler.'+@ColName+'(_'+@ColName+')'
                  SET @PublicProps = @PublicProps + 'public DateTime '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private DateTime _'+ @ColName +';' + @NewLineChar
            END
            IF @ColType= 'money'
            BEGIN
                  SET @ColType = 'Money'
                  SET @Value = 'NullHandler.Decimal(_'+@ColName+')'
                          SET @PublicProps = @PublicProps + 'public decimal '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'
                  SET @ProtdVars = @ProtdVars + 'private decimal _'+ @ColName +';' + @NewLineChar
            END


            FETCH NEXT FROM c1 INTO @ColName, @ColType

      END
END

PRINT @NewLineChar

PRINT @ProtdVars + @NewLineChar

PRINT @PublicProps + @NewLineChar