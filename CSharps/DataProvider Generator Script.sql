declare
@TableName NVARCHAR(50)='test',
 @MethodName varchar(100) = 'test'


--as
DECLARE  @ProtdVars VARCHAR(max),@PublicProps VARCHAR(max), @CMDProps VARCHAR(max), @InsertStmt VARCHAR(max), @UpdateStmt VARCHAR(max)
DECLARE  @PublicProps2 VARCHAR(max), @CMDProps2 VARCHAR(max),@CMDProps3 VARCHAR(max) , @PublicProps3 VARCHAR(max), @DRProps Varchar(max), @DRProps4 varchar(max), @DRProps2 varchar(max),@DRProps3 varchar(max)
Declare @MyString VARCHAR(max), @NewLineChar AS CHAR(2) 
SET @NewLineChar = Char(13) + CHAR(10)
DECLARE @ColName NVARCHAR(max), @ColType NVARCHAR(10)
DECLARE @Value varchar(max)
SET @ProtdVars = ''
SET @PublicProps = ''
SET @CMDProps = ''
SET @DRProps = ''
SET @DRProps4 = ''
SET @InsertStmt = ''
SET @UpdateStmt = ''
SET @PublicProps2 = ''
SET @CMDProps2 = ''
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
            
            IF @ColType= 'long'
            BEGIN
                  SET @ColType = 'long'
                  SET @Value = 'NullHandler.Int32(_'+@ColName+');'
                  SET @PublicProps = @PublicProps + 'public int? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected int? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            
            IF @ColType= 'int' OR @ColType = 'smallint' OR @ColType = 'tinyint'
            BEGIN
                  SET @ColType = 'Int'
                  SET @Value = 'NullHandler.Int32(_'+@ColName+');'
                  SET @PublicProps = @PublicProps + 'public int? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected int? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'decimal'
            BEGIN
                  SET @ColType = 'Decimal'
                  SET @Value = 'NullHandler.' + @ColType + '(_' + @ColName + ');'
                  SET @PublicProps = @PublicProps + 'public decimal? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected decimal? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'Real'
            BEGIN
                  SET @ColType = 'Real'
                  SET @Value = 'NullHandler.Decimal(_'+@ColName+');'
                  SET @PublicProps = @PublicProps + 'public decimal? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected decimal? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'bit'
            BEGIN
                  SET @ColType = 'Bit'
                  SET @Value = 'NullHandler.Boolean(_' + @ColName + ');'
                  SET @PublicProps = @PublicProps + 'public bool '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected bool _'+ @ColName +' = false;' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'nvarchar' OR @ColType= 'varchar'
            BEGIN
                  SET @ColType = 'NVarChar'
                  SET @Value = 'NullHandler.String(_' + @ColName + ');'
                  SET @PublicProps = @PublicProps + 'public string '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected string _'+ @ColName +' = "";' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'ntext' OR @ColType= 'text'
            BEGIN
                  SET @ColType = 'NText'
                  SET @Value = 'NullHandler.String(_' + @ColName + ');'
                  SET @PublicProps = @PublicProps + 'public string '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected string _'+ @ColName +' = "";' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'datetime' OR  @ColType= 'timestamp'
            BEGIN
                  SET @ColType = 'DateTime'
                  SET @Value = 'NullHandler.'+@ColType+'(_'+@ColName+');'
                  SET @PublicProps = @PublicProps + 'public DateTime? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected DateTime? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'money'
            BEGIN
                  SET @ColType = 'Money'
                  SET @Value = 'NullHandler.Decimal(_'+@ColName+');'
                  SET @PublicProps = @PublicProps + 'public decimal? '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected decimal? _'+ @ColName +';' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END
            IF @ColType= 'char'
            BEGIN
                  SET @ColType = 'char'
                  SET @Value = '_'+@ColName
                  SET @PublicProps = @PublicProps + 'public char '+ @ColName + @NewLineChar + '{'+ @NewLineChar +'get' + @NewLineChar +'{' + @NewLineChar + 'return _'+ @ColName + ';'  + @NewLineChar + '}'  + @NewLineChar + 'set'  + @NewLineChar + '{'  + @NewLineChar + '_' +@ColName + ' = value;'   + @NewLineChar + '}'  + @NewLineChar +'}'+ @NewLineChar
                  SET @ProtdVars = @ProtdVars + 'protected char _'+ @ColName +' = "";' + @NewLineChar
				  SET @DRProps = 'ParaMeterCollection.Add(new KeyValuePair("@' + @ColName + '", obj' + @MethodName + '.' +  @ColName +'));'
            END

				SET @CMDProps = @CMDProps + 'cmd.Parameters.Add("@'+@ColName+'", SqlDbType.'+@ColType+').Value = ' + @Value+@NewLineChar
				SET @DRProps4 = @DRProps4+@DRProps + @NewLineChar

			IF(LEN(@PublicProps)>7900)
			BEGIN
				IF(LEN(@PublicProps2) <= 7900)
				BEGIN
					SET @PublicProps2 = @PublicProps
					SET @PublicProps = ''
				END
				ELSE
				BEGIN
					SET @PublicProps3 = @PublicProps
					SET @PublicProps = ''				
				END
	
			END
			IF(LEN(@CmdProps)>7900)
			BEGIN
				IF(LEN(@CmdProps2) <= 7900)
				BEGIN
						SET @CmdProps2 = @CmdProps
						SET @CmdProps = ''
				END
					ELSE
				BEGIN
						SET @CmdProps3 = @CmdProps
						SET @CmdProps = ''				
				END
			END	

			IF(LEN(@DRProps4)>7900)
			BEGIN
				IF(LEN(@DRProps2) <= 7900)
				BEGIN
						SET @DRProps2 = @DRProps4
						SET @DRProps4 = ''
				END
					ELSE
				BEGIN
						SET @DRProps3 = @DRProps4
						SET @DRProps4 = ''				
				END
			END	

            FETCH NEXT FROM c1 INTO @ColName, @ColType
			END
END
PRINT 'public bool Update' + @MethodName + '(' + @MethodName +'Info obj' + @MethodName + ')
        {'
PRINT  'try
  {
	List> ParaMeterCollection = new List>();'
PRINT @NewLineChar + @DRProps4 + @NewLineChar


 PRINT 'SQLHandler sqlH = new SQLHandler();
 sqlH.ExecuteNonQuery("[dbo].[usp_Cine_Update' + @MethodName + ']", ParaMeterCollection);
    return true;
    }
    catch (Exception)
    {
	
        throw;
    }
    }' 


PRINT 'public bool Delete' + @MethodName + '(int ' + @MethodName +'ID)
        {'
PRINT  'try
  {
	List> ParaMeterCollection = new List>();
	 
	 ParaMeterCollection.Add(new KeyValuePair("@' + @MethodName + 'ID", ' +  @MethodName +'ID));'
	 
	
 PRINT 'SQLHandler sqlH = new SQLHandler();
 sqlH.ExecuteNonQuery("[dbo].[usp_Cine_Delete' + @MethodName + ']", ParaMeterCollection);
    return true;
    }
    catch (Exception)
    {
	
        throw;
    }
    }'