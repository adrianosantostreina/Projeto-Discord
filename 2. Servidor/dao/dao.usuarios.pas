unit dao.usuarios;

interface

uses
  ADRConn.DAO.Base,
  ADRConn.Model.Factory,
  ADRConn.Model.Interfaces,

  Data.DB,

  DataSet.Serialize,

  System.Classes,
  System.JSON,
  System.StrUtils,
  System.SysUtils;

type
  TADRConnDAOUsuario = class(TADRConnDAOBase)
    private

    public
      function List: TJSONArray;
      function Find(AID: Integer): TJSONObject;
      function Insert(AValue: string): TJSONObject;
      function Update(AID: Integer; AValue: string): TJSONObject;
      function Delete(AID: Integer): TJSONObject;
  end;

implementation

{ TADRConnDAOUsuario }

function TADRConnDAOUsuario.List: TJSONArray;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, USUARIO, SENHA, TIPOUSUARIO FROM USUARIOS ORDER BY ID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataset :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;
      Result := LDataset.ToJSONArray;
    except
      Result := TJSONArray.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOUsuario.Find(AID: Integer): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, USUARIO, SENHA, TIPOUSUARIO FROM USUARIOS WHERE ID =:pID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataset :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;
      Result := LDataset.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TADRConnDAOUsuario.Insert(AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, USUARIO, SENHA, TIPOUSUARIO FROM USUARIOS WHERE 1 = 2';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .OpenDataSet;

      LDataSet
        .LoadFromJSON(AValue);

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOUsuario.Update(AID: Integer; AValue: string): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, USUARIO, SENHA, TIPOUSUARIO FROM USUARIOS WHERE ID = :pID ORDER BY ID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      LDataSet
        .MergeFromJSONObject(AValue);

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;

function TADRConnDAOUsuario.Delete(AID: Integer): TJSONObject;
{$Region 'SELECT'}
const
  LSelect =
    'SELECT ID, USUARIO, SENHA, TIPOUSUARIO FROM USUARIOS WHERE ID = :pID';
{$EndRegion}
var
  LDataSet : TDataSet;
begin
  try
    try
      LDataSet :=
        FQuery
          .SQL(LSelect)
          .ParamAsInteger('pID', AID)
          .OpenDataSet;

      //Exclus�o F�sica
      LDataSet.Delete;

//      //Exclus�o L�giga - Requer o JSON no Body
//      LDataSet
//        .MergeFromJSONObject(AValue);

      Result := LDataSet.ToJSONObject;
    except
      Result := TJSONObject.Create;
    end;
  finally
    LDataSet.Free;
  end;

end;


end.

