FUNCTION_BLOCK WriteLocalODEntry
VAR CONSTANT

    (* Definition of Data types *)
    SOO_DT_BYTE     : USINT := 1;
    SOO_DT_WORD     : USINT := 2;
    SOO_DT_DWORD    : USINT := 4;

    DEVICE          : USINT := 0;   (* Device 0: local device            *)

END_VAR

VAR_INPUT

    usiNetNumber_i  : USINT;        (* Netnumber: 0=CAN=, 1=CAN1         *)
    wIndex_i        : WORD;         (* Index to read                     *)
    bSubIndex_i     : BYTE;         (* SubIndex to read                  *)
    dwData_i        : DWORD;        (* Data to write into OD entry       *)
    usiDataType_i   : USINT;        (* DataType: 1=Byte, 2=Word, 4=Dword *)

END_VAR

VAR_OUTPUT

    xSuccess_o      : BOOL;         (* TRUE if SDO was successful        *)
    wError_o        : WORD;
    dwErrorInfo_o   : DWORD;

END_VAR

VAR

    FB_CanSdoWrite8 : CAN_SDO_WRITE8;

END_VAR

(*=========================================================================*)
(*      FUNCTIONBLOCK WriteLocalODEntry                                    *)
(*=========================================================================*)
(*                                                                         *)
(* This Function Block is used to write a numeric entry into the local     *)
(* Object Dictionary.                                                      *)
(*                                                                         *)
(* Note: This Function Block is only usable for accessing to the *LOCAL*   *)
(*       Object Dictionary. To write object entries into a remote node,    *)
(*       it is necessary to implement the complete ENABLE/CONFIRM          *)
(*       handshake procedure as described in "User Manual CANopen          *)
(*       Extension for IEC61131-3", Manual-no.: L-1008.                    *)
(*                                                                         *)
(*-------------------------------------------------------------------------*)
(*      (c) SYSTEC electronic GmbH 2009     -rs                            *)
(*=========================================================================*)


FB_CanSdoWrite8.DATA3 := DWORD_TO_BYTE(SHR(dwData_i, 24));
FB_CanSdoWrite8.DATA2 := DWORD_TO_BYTE(SHR(dwData_i, 16));
FB_CanSdoWrite8.DATA1 := DWORD_TO_BYTE(SHR(dwData_i,  8));
FB_CanSdoWrite8.DATA0 := DWORD_TO_BYTE(    dwData_i     );


FB_CanSdoWrite8 (
    NETNUMBER     := usiNetNumber_i,
    DEVICE        := DEVICE,
    INDEX         := wIndex_i,
    SUBINDEX      := bSubIndex_i,
    DATALENGTH    := usiDataType_i,
    ENABLE        := TRUE
    |
    xSuccess_o    := CONFIRM,
    wError_o      := ERROR,
    dwErrorInfo_o := ERRORINFO);


FB_CanSdoWrite8 (ENABLE := FALSE);

RETURN;




END_FUNCTION_BLOCK