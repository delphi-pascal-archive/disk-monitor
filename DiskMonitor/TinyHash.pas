                                                                                                    {
____________________________________________________________________________________________________

  TinyHash v1.0.2 - for Delphi - by f0xi - 02/07/2007

  <!> based on AdvApi32 // no 1:1 header <!>

  Web resources :

  C sources of ADVAPI32 ::
     http://source.winehq.org/source/dlls/advapi32/crypt_sha.c
     http://source.winehq.org/source/dlls/advapi32/crypt_md4.c
     http://source.winehq.org/source/dlls/advapi32/crypt_md5.c

     thanks fly to Alexandre Julliard of source.winehq.org

  Wikipedia references of hash ::
     http://fr.wikipedia.org/wiki/SHA-1
     http://fr.wikipedia.org/wiki/MD4
     http://fr.wikipedia.org/wiki/MD5


____________________________________________________________________________________________________

  Revision 1.0.2 - 09/02/2007
  - ajout des fonctions de comparaisons
  - ajout d'une procedure CallBack pour les hash sur les streams

  Revision 1.0.1 - 08/02/2007
  - ajout d'exemples
  - ajout commentaires et declarations d'origine
  - declinaison des types SHA, MD4 et MD5 en convention Delphi
  - fixé le type pMD5_CTX qui pointait sur MD4_CTX
____________________________________________________________________________________________________


-- SHA1 exemples -----------------------------------------

Free use :

   var CT : SHA1_CTX; // hash context
       DG : SHA1_DIG; // hash digest
   begin
     // Initialization
     SHA1Init(@CT);

     //>> start of loop here (while, repeat, for)

          //>> define Data block and Data block size

          // Update context
          SHA1Update(@CT, ?Data?, ?DataSize?);

     //>> end of loop here

     // Finalization
     SHA1Final(@CT,@DG);

     // Show hash
     Edit1.Text := SHA1ToStr( DG );
   end;


Get SHA1 from untyped buffer :

   Var C : integer;
   begin
     C := clYellow;
     Edit1.Text := SHA1ToStr( SHA1(C, SizeOf(integer)) );
   end;


Get SHA1 from string :

   Edit1.Text := SHA1ToStr( SHA1('Hello world!') );


Get SHA1 from file :

   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := SHA1ToStr( SHA1(Stream) );
        Finally
          Stream.Free;
        end;
     end;
   end;


Get SHA1 from file with CallBack :

   procedure HashCallBack(const TotalSize, Position : int64;const PassCounter : integer);
   begin
     // all three pass
     if (PassCounter mod 3) = 0 then begin
        // compute the percentage of progress
        ProgressBar.Position := round((100/TotalSize)*Position);
        // refresh applications
        Application.ProcessMessage;
     end;
   end;

   ...
   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := SHA1ToStr( SHA1(Stream, HashCallBack) );
        Finally
          Stream.Free;
        end;
     end;
   end;


SHA1 digest comparison :

   if SHA1Compare( SHA1('Hello World'), SHA1('Hello World!') ) then
      ShowMessage('Identical')
   else
      ShowMessage('Different');


Recommandations :
  For save a SHA1 hash in file, don't save the string representation (40 bytes)
  but the SHA1 Digest (SHA1_DIG) (20 bytes).


-- MD4 exemples ------------------------------------------

Free use :

   var CT : MD4_CTX; // hash context
   begin
     // Initialization
     MD4Init(CT);

     //>> start of loop here (while, repeat, for)

          //>> define Data block and Data block size

          // Update context
          MD4Update(CT, ?Data?, ?DataSize?);

     //>> end of loop here

     // Finalization
     MD4Final(CT);

     // Show hash
     Edit1.Text := MD4ToStr( CT._Digest );
   end;


Get MD4 from untyped buffer :

   Var C : integer;
   begin
     C := clYellow;
     Edit1.Text := MD4ToStr( MD4(C, SizeOf(integer)) );
   end;


Get MD4 from string :
   Edit1.Text := MD4ToStr( MD4('Hello world!') );


Get MD4 from file :

   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := MD4ToStr( MD4(Stream) );
        Finally
          Stream.Free;
        end;
     end;
   end;


Get MD4 from file with CallBack :

   procedure HashCallBack(const TotalSize, Position : int64;const PassCounter : integer);
   begin
     // all three pass
     if (PassCounter mod 3) = 0 then begin
        // compute the percentage of progress
        ProgressBar.Position := round((100/TotalSize)*Position);
        // refresh applications
        Application.ProcessMessage;
     end;
   end;

   ...
   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := MD4ToStr( MD4(Stream, HashCallBack) );
        Finally
          Stream.Free;
        end;
     end;
   end;


MD4 digest comparison :

   if MD4Compare( MD4('Hello World'), MD4('Hello World!') ) then
      ShowMessage('Identical')
   else
      ShowMessage('Different');


Recommandations :
  For save a MD4 hash in file, don't save the string representation (32 bytes)
  but the MD4 Digest (MD4_DIG) (16 bytes).


-- MD5 exemples ------------------------------------------

Free use :

   var CT : MD5_CTX; // hash context
   begin
     // Initialization
     MD5Init(CT);

     //>> start of loop here (while, repeat, for)

          //>> define Data block and Data block size

          // Update context
          MD5Update(CT, ?Data?, ?DataSize?);

     //>> end of loop here

     // Finalization
     MD5Final(CT);

     // Show hash
     Edit1.Text := MD5ToStr( CT._Digest );
   end;


Get MD5 from untyped buffer :

   Var C : integer;
   begin
     C := clYellow;
     Edit1.Text := MD5ToStr( MD5(C, SizeOf(integer)) );
   end;


Get MD5 from string :

   Edit1.Text := MD5ToStr( MD5('Hello world!') );


Get MD5 from file :

   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := MD5ToStr( MD5(Stream) );
        Finally
          Stream.Free;
        end;
     end;
   end;


Get MD5 from file with CallBack :

   procedure HashCallBack(const TotalSize, Position : int64;const PassCounter : integer);
   begin
     // all three pass
     if (PassCounter mod 3) = 0 then begin
        // compute the percentage of progress
        ProgressBar.Position := round((100/TotalSize)*Position);
        // refresh applications
        Application.ProcessMessage;
     end;
   end;

   ...
   Var Stream : TStream;
   begin
     If OpenDialog1.Execute then begin
        Stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
        Try
          Edit1.Text := MD5ToStr( MD5(Stream, HashCallBack) );
        Finally
          Stream.Free;
        end;
     end;
   end;


MD5 digest comparison :

   if MD5Compare( MD5('Hello World'), MD5('Hello World!') ) then
      ShowMessage('Identical')
   else
      ShowMessage('Different');


Recommandations :
  For save a MD5 hash in file, don't save the string representation (32 bytes)
  but the MD5 Digest (MD5_DIG) (16 bytes).


____________________________________________________________________________________________________}


unit TinyHash;


INTERFACE


uses windows, sysutils, Classes;


type
  {** TCallBackHashProc

      Called by SHA1, MD4 and MD5 for streams.

      Params
        TotalSize   [I] size of stream
        Position    [I] current position in stream
        PassCounter [I] pass count
  }
  TCallBackHashProc = procedure (const TotalSize, Position : int64; const PassCounter : integer);

{
----------------------------------------------------------------------------------------------------
SHA1
----------------------------------------------------------------------------------------------------
}

type
  {** SHA1 Digest }
  pSHA1_DIG = ^SHA1_DIG;
  SHA1_DIG  = array[0..4] of cardinal;

  pSHA1Digest = pSHA1_DIG;
  TSHA1Digest = SHA1_DIG;


  {** SHA1 Context }
      (* SHA Context Structure Declaration

         typedef struct {
           ULONG Unknown[6];
           ULONG State[5];
           ULONG Count[2];
           UCHAR Buffer[64];
         } SHA_CTX, *PSHA_CTX;
      *)
  pSHA1_CTX = ^SHA1_CTX;
  SHA1_CTX  = record
    _Unknow : array[0..5]  of cardinal;
    _State  : array[0..4]  of cardinal;
    _Count  : array[0..1]  of cardinal;
    _Buffer : array[0..63] of byte;
  end;

  pSHA1Context = pSHA1_CTX;
  TSHA1Context = SHA1_CTX;


  {** SHA1 Initialization }
      (* A_SHAInit [ADVAPI32.@] >> SHA1Init

         Initialize a SHA context structure.

         PARAMS
         ( pCtx ) Context [O] SHA context

         VOID WINAPI A_SHAInit(PSHA_CTX Context)
      *)
procedure SHA1Init(const pCtx : pSHA1_CTX); stdcall;


  {** SHA1 Update }
      (* A_SHAUpdate [ADVAPI32.@] >> SHA1Update

         Update a SHA context with a hashed data from supplied buffer.

         PARAMS
         ( pCtx       ) Context    [I/O] SHA context
         ( Buffer     ) Buffer     [I] hashed data
         ( BufferSize ) BufferSize [I] hashed data size

         VOID WINAPI A_SHAUpdate(PSHA_CTX Context, const unsigned char *Buffer, UINT BufferSize)
      *)
procedure SHA1Update(const pCtx : pSHA1_CTX; const Buffer; const BufferSize : integer); stdcall;


  {** SHA1 Finalization }
      (* A_SHAFinal [ADVAPI32.@] >> SHA1Final

         Finalize SHA context and return the resulting hash.

         PARAMS
         ( pCtx    ) Context [I/O] SHA context
         ( pResult ) Result  [O] resulting hash

         VOID WINAPI A_SHAFinal(PSHA_CTX Context, PULONG Result)
      *)
procedure SHA1Final(const pCtx : pSHA1_CTX; const pResult : pSHA1_DIG); stdcall;


const
  { Size of SHA1 digest :: 160 bits = 20 bytes }
  SHA1_DIG_SIZE = SizeOf(SHA1_DIG);
  SHA1_STR_SIZE = SHA1_DIG_SIZE shl 1;


{** SHA1 for untyped buffer

  Make SHA1 hash from untyped buffer

  Params
    Buffer      [I] untyped buffer
    BufferSize  [I] size of buffer, use SizOf or Length to define it.

  Return
    SHA1 Digest
}
function SHA1(const Buffer; const BufferSize : integer) : TSHA1Digest; overload;


{** SHA1 for String

  Make SHA1 hash from string

  Params
    S  [I] all strings type

  Return
    SHA1 Digest
}
function SHA1(const S : String) : TSHA1Digest; overload;


{** SHA1 for Stream class

  Make SHA1 hash from stream object (use 64Kb buffer by pass)

  Params
    Stream       [I] TStream, TFileStream or TMemoryStream class
    (2) CallBack [I] CallBack proc for progress of hash

  Return
    SHA1 Digest
}
function SHA1(Stream : TStream) : TSHA1Digest; overload;
function SHA1(Stream : TStream; const CallBack : TCallBackHashProc) : TSHA1Digest; overload;


{** SHA1 digest to string

  Get literary (hex) representation from SHA1 Digest

  Params
    Digest [I] SHA1 Digest

  Return
    String
}
function SHA1ToStr(const Digest : TSHA1Digest) : string;


{** SHA1 comparison

  Compare two SHA1 digest and return true or false if they're identical.

  Params
    DigA [I] SHA1 Digest
    DigB [I] SHA1 Digest

  Return
    boolean, true if identical
}
function SHA1Compare(const DigA,DigB : TSHA1Digest) : boolean;


{** SHA1 string to SHA1 digest

  converting a SHA1 hash string representation in SHA1 digest.

  Params
    S [I] SHA1 hash string representation

  Return
    SHA1 Digest
}
function HashStrToSHA1(const S : String) : TSHA1Digest;


{**
  -

  Params

  Return
}
function SHA1StrCheck(const S : string) : boolean;

{
----------------------------------------------------------------------------------------------------
MD4
----------------------------------------------------------------------------------------------------
}

type
  {** MD4 Digest }
  pMD4_DIG = ^MD4_DIG;
  MD4_DIG  = array[0..15] of byte;

  pMD4Digest = pMD4_DIG;
  TMD4Digest = MD4_DIG;


  {** MD4 Context }
      (* MD4 Context Structure Declaration

         typedef struct {
           unsigned int buf[4];
           unsigned int i[2];
           unsigned char in[64];
           unsigned char digest[16];
         } MD4_CTX;
      *)
  pMD4_CTX = ^MD4_CTX;
  MD4_CTX  = record
    _Buf    : array[0..3] of cardinal;
    _I      : array[0..1] of cardinal;
    _In     : array[0..63] of byte;
    _Digest : MD4_DIG;
  end;

  pMD4Context = pMD4_CTX;
  TMD4Context = MD4_CTX;


  {** MD4 Initialization }
      (* MD4Init [ADVAPI32.@] >> MD4Init

         Start MD4 accumulation. Set bit count to 0 and buffer to mysterious
         initialization constants.

         PARAMS
         ( ctx ) ctx [O] MD4 context

         VOID WINAPI MD4Init( MD4_CTX *ctx )
      *)
procedure MD4Init(var ctx : MD4_CTX); stdcall;


  {** MD4 Update }
      (* MD4Update [ADVAPI32.@] >> MD4Update

         Update context to reflect the concatenation of another buffer full
         of bytes.

         PARAMS
         ( ctx        ) ctx  [I/O] MD4 context
         ( Buffer     ) buf  [I]   hashed data
         ( BufferSize ) len  [I]   hashed data size

         VOID WINAPI MD4Update( MD4_CTX *ctx, const unsigned char *buf, unsigned int len )
      *)
procedure MD4Update(var ctx : MD4_CTX; const Buffer; const BufferSize : integer); stdcall;


  {** MD4 Finalization }
      (* MD4Final [ADVAPI32.@] >> MD4Final

        Final wrapup - pad to 64-byte boundary with the bit pattern
        1 0* (64-bit count of bits processed, MSB-first)

        PARAMS
        ( ctx ) ctx [I/O] MD4 context

        VOID WINAPI MD4Final( MD4_CTX *ctx )
      *)
procedure MD4Final(var ctx : MD4_CTX); stdcall;


const
  { Size of MD4 Digest :: 128bits = 16 bytes }
  MD4_DIG_SIZE = SizeOf(MD4_DIG);
  MD4_STR_SIZE = MD4_DIG_SIZE shl 1;

{** MD4 for untyped buffer

  Make MD4 hash from untyped buffer

  Params
    Buffer      [I] untyped buffer
    BufferSize  [I] size of buffer, use SizOf or Length to define it.

  Return
    MD4 Digest
}
function MD4(const Buffer; const BufferSize : integer) : TMD4Digest; overload;


{** MD4 for String

  Make MD4 hash from string

  Params
    S  [I] all strings type

  Return
    MD4 Digest
}
function MD4(const S : string) : TMD4Digest; overload;


{** MD4 for Stream class

  Make MD4 hash from stream object (use 64Kb buffer by pass)

  Params
    Stream       [I] TStream, TFileStream or TMemoryStream class
    (2) CallBack [I] CallBack proc for progress of hash

  Return
    MD4 Digest
}
function MD4(Stream : TStream) : TMD4Digest; overload;
function MD4(Stream : TStream; const CallBack : TCallBackHashProc) : TMD4Digest; overload;


{** MD4 digest to string

  Get literary (hex) representation from MD4 Digest

  Params
    Digest [I] MD4 Digest

  Return
    String
}
function MD4ToStr(const Digest : TMD4Digest) : string;


{** MD4 comparison

  Compare two MD4 digest and return true or false if they're identical.

  Params
    DigA [I] MD4 Digest
    DigB [I] MD4 Digest

  Return
    boolean, true if identical
}
function MD4Compare(const DigA,DigB : TMD4Digest) : boolean;


{** MD4 string to MD4 digest

  converting a MD4 hash string representation in MD4 digest.

  Params
    S [I] MD4 hash string representation

  Return
    MD4 Digest
}
function HashStrToMD4(const S : String) : TMD4Digest;


{**
  -

  Params

  Return
}
function MD4StrCheck(const S : string) : boolean;


{
----------------------------------------------------------------------------------------------------
MD5
----------------------------------------------------------------------------------------------------
}

type
  {** MD5 Digest }
  pMD5_DIG = ^MD5_DIG;
  MD5_DIG  = array[0..15] of byte;

  pMD5Digest = pMD5_DIG;
  TMD5Digest = MD5_DIG;


  {** MD5 Context }
      (* MD5 Context Structure Declaration

         typedef struct {
           unsigned int i[2];
           unsigned int buf[4];
           unsigned char in[64];
           unsigned char digest[16];
         } MD5_CTX;
      *)
  pMD5_CTX = ^MD5_CTX;
  MD5_CTX  = record
    _I      : array[0..1] of cardinal;
    _Buf    : array[0..3] of cardinal;
    _In     : array[0..63] of byte;
    _Digest : MD5_DIG;
  end;

  pMD5Context = pMD5_CTX;
  TMD5Context = MD5_CTX;


  {** MD5 Initialization }
      (* MD5Init [ADVAPI32.@] >> MD5Init
         Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
         initialization constants.

         PARAMS
         ( ctx ) ctx [O] MD5 Context

         VOID WINAPI MD5Init( MD5_CTX *ctx )
       *)
procedure MD5Init(var ctx : MD5_CTX); stdcall;


  {** MD5 Update }
      (* MD5Update [ADVAPI32.@] >> MD5Update

         Update context to reflect the concatenation of another buffer full
         of bytes.

         PARAMS
         ( ctx        ) ctx [I/O] MD5 Context
         ( Buffer     ) buf [I] Hashed data
         ( BufferSize ) len [I] Hashed data size

         VOID WINAPI MD5Update( MD5_CTX *ctx, const unsigned char *buf, unsigned int len )
      *)
procedure MD5Update(var ctx : MD5_CTX; const Buffer; const BufferSize : integer); stdcall;


  {** MD5 Finalization }
      (* MD5Final [ADVAPI32.@] >> MD5Final

         Final wrapup - pad to 64-byte boundary with the bit pattern
         1 0* (64-bit count of bits processed, MSB-first)

         PARAMS
         ( ctx ) ctx [I/O] MD5 Context

         VOID WINAPI MD5Final( MD5_CTX *ctx )
      *)
procedure MD5Final(var ctx : MD5_CTX); stdcall;


const
  { Size of MD5 Digest :: 128bits = 16 bytes }
  MD5_DIG_SIZE = SizeOf(MD5_DIG);
  MD5_STR_SIZE = MD5_DIG_SIZE shl 1;

{** MD5 for untyped buffer

  Make MD5 hash from untyped buffer

  Params
    Buffer      [I] untyped buffer
    BufferSize  [I] size of buffer, use SizOf or Length to define it.

  Return
    MD5 Digest
}
function MD5(const Buffer; const BufferSize : integer) : TMD5Digest; overload;


{** MD5 for String

  Make MD5 hash from string

  Params
    S  [I] all strings type

  Return
    MD5 Digest
}
function MD5(const S : string) : TMD5Digest; overload;


{** MD5 for Stream class

  Make MD5 hash from Stream object (use 64Kb buffer by pass)

  Params
    Stream       [I] TStream, TFileStream or TMemoryStream class
    (2) CallBack [I] CallBack proc for progress of hash

  Return
    MD5 Digest
}
function MD5(Stream : TStream) : TMD5Digest; overload;
function MD5(Stream : TStream; const CallBack : TCallBackHashProc) : TMD5Digest; overload;


{** MD5 digest to string

  Get literary (hex) representation from MD5 Digest

  Params
    Digest [I] MD5 Digest

  Return
    String
}
function MD5ToStr(const Digest : TMD5Digest) : string;


{** MD5 comparison

  Compare two MD5 digest and return true or false if they're identical.

  Params
    DigA [I] MD5 Digest
    DigB [I] MD5 Digest

  Return
    boolean, true if identical
}
function MD5Compare(const DigA,DigB : TMD5Digest) : boolean;


{** MD5 string to MD5 digest

  converting a MD5 hash string representation in MD5 digest.

  Params
    S [I] MD5 hash string representation

  Return
    MD5 Digest
}     
function HashStrToMD5(const S : String) : TMD5Digest;


{**
  -

  Params

  Return
}
function MD5StrCheck(const S : string) : boolean;

                                                                                                    {
____________________________________________________________________________________________________}

IMPLEMENTATION                                                                                      {
____________________________________________________________________________________________________}


{** HashStrCheck

  Private use only.
  Check hash string representation.

  Params
    S           [I] hash string representation
    HashStrSize [I] hash string size (use ???_STR_SIZE constantes)

  Return
    boolean
}
function HashStrCheck(const S : string; const HashStrSize : word) : boolean;
var N,L : integer;
begin
  N      := 1;
  L      := Length(S)+1;
  result := L = HashStrSize;
  while Result and (N < L) do begin
     Result := S[N] in ['0'..'9','a'..'f','A'..'F'];
     inc(N);
  end;
end;


{** HashStrToHashDigest

  Private use only.
  Convert Hash string representation in hash digest.

  Params
    S              [I] hash string representation
    Digest         [O] hash digest
    HashDigestSize [I] hash digest size (use ???_DIG_SIZE constantes)
    HashStrSize    [I] hash string size (use ???_STR_SIZE constantes)
}
procedure HashStrToHashDigest(const S : String; const Digest; const HashDigestSize, HashStrSize : integer);
var
  pB   : ^Byte;
  N,SP : integer;
begin
  if not HashStrCheck(S,HashStrSize) then
     exit;

  pB := @Digest;
  for N := 0 to HashDigestSize-1 do begin
      SP  := (N shl 1)+1;
      pB^ := byte(StrToInt('$'+S[SP]+S[SP+1]));
      inc(pB);
  end;
end;


{** DataToStr

  Private use only.
  Convert Data to Hex string representation.

  Params
    Data     [I] untyped data
    DataSize [I] size of data
    R        [O] result string (Hex format)
}
procedure DataToStr(const Data; const DataSize : integer; var R : string);
var
  pR : PChar;
  pB : ^byte;
  N  : integer;
const
  Dig : array[$0..$F] of char = '0123456789abcdef';
begin
  SetLength(R, DataSize shl 1);
  pR := PChar(R);
  pB := @Data;
  for N := 0 to DataSize-1 do begin
      pR[0] := Dig[pB^ shr 4];
      pR[1] := Dig[pB^ and $F];
      inc(pR,2);
      inc(pB);
  end;
end;


{** Min

  Private use only.
  Get the smaller integer from A or B.

  Params
    A [I] first integer
    B [I] second integer
    R [O] return A or B
}
procedure Min(const A,B : integer; var R : integer);
begin
  if A < B then R := A else R := B;
end;


{ MD5 -------------------------------------------------------------------------------------------- }

function MD5StrCheck(const S : string) : boolean;
begin
  result := HashStrCheck(s, MD5_STR_SIZE);
end;

function HashStrToMD5(const S : String) : TMD5Digest;
begin
  HashStrToHashDigest(S,result,MD5_DIG_SIZE,MD5_STR_SIZE);
end;

function MD5Compare(const DigA,DigB : TMD5Digest) : boolean;
begin
  result := CompareMem(@DigA,@DigB, MD5_DIG_SIZE);
end;

function MD5ToStr(const Digest : TMD5Digest) : string;
begin
  DataToStr(Digest, MD5_DIG_SIZE, Result);
end;

function MD5(Stream : TStream; const CallBack : TCallBackHashProc) : TMD5Digest;
var StreamBuffer   : array[word] of byte;
    L,Mw,PassCount : integer;
    CT             : MD5_CTX;
begin
  if not assigned(Stream) then exit;

  PassCount := 0;
  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  MD5Init(CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        MD5Update(CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
        PassCount := PassCount + 1;
        CallBack(Stream.Size, Stream.Position, PassCount);
  end;

  MD5Final(CT);

  result := CT._Digest;
end;

function MD5(Stream : TStream) : TMD5Digest;
var StreamBuffer : array[word] of byte;
    L,Mw         : integer;
    CT           : MD5_CTX;
begin
  if not assigned(Stream) then exit;

  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  MD5Init(CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        MD5Update(CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
  end;

  MD5Final(CT);

  result := CT._Digest;
end;

function MD5(const S : string) : TMD5Digest;
var CT : MD5_CTX;
begin
  MD5Init(CT);
  MD5Update(CT, PChar(S)^, Length(S));
  MD5Final(CT);
  result := CT._Digest;
end;

function MD5(const Buffer; const BufferSize : integer) : TMD5Digest;
var CT : MD5_CTX;
begin
  MD5Init(CT);
  MD5Update(CT, Buffer, BufferSize);
  MD5Final(CT);
  result := CT._Digest;
end;


{ MD4 -------------------------------------------------------------------------------------------- }


function MD4StrCheck(const S : string) : boolean;
begin
  result := HashStrCheck(s, MD4_STR_SIZE);
end;

function HashStrToMD4(const S : String) : TMD4Digest;
begin
  HashStrToHashDigest(S,result,MD4_DIG_SIZE,MD4_STR_SIZE);
end;

function MD4Compare(const DigA,DigB : TMD4Digest) : boolean;
begin
  result := CompareMem(@DigA,@DigB, MD4_DIG_SIZE);
end;

function MD4ToStr(const Digest : TMD4Digest) : string;
begin
  DataToStr(Digest, MD4_DIG_SIZE, Result);
end;

function MD4(Stream : TStream; const CallBack : TCallBackHashProc) : TMD4Digest;
var StreamBuffer   : array[word] of byte;
    L,Mw,PassCount : integer;
    CT             : MD4_CTX;
begin
  if not assigned(Stream) then exit;

  PassCount := 0;
  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  MD4Init(CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        MD4Update(CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
        PassCount := PassCount + 1;
        CallBack(Stream.Size, Stream.Position, PassCount);
  end;

  MD4Final(CT);

  result := CT._Digest;
end;

function MD4(Stream : TStream) : TMD4Digest;
var StreamBuffer : array[word] of byte;
    L,Mw         : integer;
    CT           : MD4_CTX;
begin
  if not assigned(Stream) then exit;

  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  MD4Init(CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        MD4Update(CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
  end;

  MD4Final(CT);

  result := CT._Digest;
end;

function MD4(const S : string) : TMD4Digest;
var CT : MD4_CTX;
begin
  MD4Init(CT);
  MD4Update(CT, PChar(S)^, Length(S));
  MD4Final(CT);
  result := CT._Digest;
end;

function MD4(const Buffer; const BufferSize : integer) : TMD4Digest;
var CT : MD4_CTX;
begin
  MD4Init(CT);
  MD4Update(CT, Buffer, BufferSize);
  MD4Final(CT);
  result := CT._Digest;
end;


{ SHA1 ------------------------------------------------------------------------------------------- }


function SHA1StrCheck(const S : string) : boolean;
begin
  result := HashStrCheck(s, SHA1_STR_SIZE);
end;

function HashStrToSHA1(const S : String) : TSHA1Digest;
begin
  HashStrToHashDigest(S,result,SHA1_DIG_SIZE,SHA1_STR_SIZE);
end;

function SHA1Compare(const DigA,DigB : TSHA1Digest) : boolean;
begin
  result := CompareMem(@DigA,@DigB, SHA1_DIG_SIZE);
end;

function SHA1ToStr(const Digest : TSHA1Digest) : string;
begin
  DataToStr(Digest, SHA1_DIG_SIZE, Result);
end;
                     

function SHA1(Stream : TStream; const CallBack : TCallBackHashProc) : TSHA1Digest;
var StreamBuffer   : array[word] of byte;
    L,Mw,PassCount : integer;
    CT             : SHA1_CTX;
begin
  if not assigned(Stream) then exit;

  PassCount := 0;
  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  SHA1Init(@CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        SHA1Update(@CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
        PassCount := PassCount + 1;
        CallBack(Stream.Size, Stream.Position, PassCount);
  end;

  SHA1Final(@CT,@Result);
end;

function SHA1(Stream : TStream) : TSHA1Digest;
var StreamBuffer : array[word] of byte;
    L,Mw         : integer;
    CT           : SHA1_CTX;
begin
  if not assigned(Stream) then exit;

  Mw := High(Word);
  Min(Stream.Size, Mw, L);

  SHA1Init(@CT);

  Stream.Position := 0;
  while Stream.Position < Stream.Size-1 do begin
        Stream.ReadBuffer(StreamBuffer,L);
        SHA1Update(@CT, StreamBuffer, L);
        Min(Stream.Size-Stream.Position, Mw, L);
  end;

  SHA1Final(@CT,@Result);
end;

function SHA1(const S : String) : TSHA1Digest;
var CT : SHA1_CTX;
begin
  SHA1Init(@CT);
  SHA1Update(@CT, PChar(S)^, Length(S));
  SHA1Final(@CT, @Result);
end;

function SHA1(const Buffer; const BufferSize : integer) : TSHA1Digest;
var CT : SHA1_CTX;
begin
  SHA1Init(@CT);
  SHA1Update(@CT, Buffer, BufferSize);
  SHA1Final(@CT, @result);
end;



{ ADVAPI32 --------------------------------------------------------------------------------------- }

const
  LIB_ADVAPI32 = 'advapi32.dll';

{ MD5 imports }
procedure MD5Init(var ctx : MD5_CTX);
  external LIB_ADVAPI32 name 'MD5Init';
procedure MD5Update(var ctx : MD5_CTX; const Buffer; const BufferSize : integer);
  external LIB_ADVAPI32 name 'MD5Update';
procedure MD5Final(var ctx : MD5_CTX);
  external LIB_ADVAPI32 name 'MD5Final';

{ MD4 imports }
procedure MD4Init(var ctx : MD4_CTX);
  external LIB_ADVAPI32 name 'MD4Init';
procedure MD4Update(var ctx : MD4_CTX; const Buffer; const BufferSize : integer);
  external LIB_ADVAPI32 name 'MD4Update';
procedure MD4Final(var ctx : MD4_CTX);
  external LIB_ADVAPI32 name 'MD4Final';

{ SHA1 imports }
procedure SHA1Init(const pCtx : pSHA1_CTX);
  external LIB_ADVAPI32 name 'A_SHAInit';
procedure SHA1Update(const pCtx : pSHA1_CTX; const Buffer; const BufferSize : integer);
  external LIB_ADVAPI32 name 'A_SHAUpdate';
procedure SHA1Final(const pCtx : pSHA1_CTX; const pResult : pSHA1_DIG);
  external LIB_ADVAPI32 name 'A_SHAFinal';


end.
 