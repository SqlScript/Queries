--select dbo.GetHttp('http://localhost/page1?ID=')

CREATE FUNCTION [dbo].[GetHttp] (@url VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
BEGIN
 DECLARE @win INT
 DECLARE @hr INT
 DECLARE @text VARCHAR(8000)

 EXEC @hr = sp_OACreate 'WinHttp.WinHttpRequest.5.1'
  ,@win OUT

 IF @hr <> 0
  EXEC sp_OAGetErrorInfo @win

 EXEC @hr = sp_OAMethod @win
  ,'Open'
  ,NULL
  ,'GET'
  ,@url
  ,'false'

 IF @hr <> 0
  EXEC sp_OAGetErrorInfo @win

 EXEC @hr = sp_OAMethod @win
  ,'Send'

 IF @hr <> 0
  EXEC sp_OAGetErrorInfo @win

 EXEC @hr = sp_OAGetProperty @win
  ,'ResponseText'
  ,@text OUTPUT

 IF @hr <> 0
  EXEC sp_OAGetErrorInfo @win

 EXEC @hr = sp_OADestroy @win

 IF @hr <> 0
  EXEC sp_OAGetErrorInfo @win

 RETURN @text
END

