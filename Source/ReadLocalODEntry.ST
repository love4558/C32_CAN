FUNCTION_BLOCK ReadLocalODEntry
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

END_VAR

VAR_OUTPUT

    dwData_o        : DWORD;        (* Data read from OD entry           *)
    usiDataType_o   : USINT;        (* DataType: 1=Byte, 2=Word, 4=Dword *)
    xSuccess_o      : BOOL;         (* TRUE if SDO was successful        *)
    wError_o        : WORD;
    dwErrorInfo_o   : DWORD;

END_VAR

VAR

    FB_CanSdoRead8  : CAN_SDO_READ8;

END_VAR

(*=========================================================================*)
(*      FUNCTIONBLOCK ReadLocalODEntry                                     *)
(*=========================================================================*)
(*                                                                         *)
(* This Function Block is used to read a numeric entry from the local      *)
(* Object Dictionary.                                                      *)
(*                                                                         *)
(* Note: This Function Block is only usable for accessing to the *LOCAL*   *)
(*       Object Dictionary. To read object entries from a remote node,     *)
(*       it is necessary to implement the complete ENABLE/CONFIRM          *)
(*       handshake procedure as described in "User Manual CANopen          *)
(*       Extension for IEC61131-3", Manual-no.: L-1008.                    *)
(*                                                                         *)
(*-------------------------------------------------------------------------*)
(*      (c) SYSTEC electronic GmbH 2009     -rs                            *)
(*=========================================================================*)


FB_CanSdoRead8 (
    NETNUMBER     := usiNetNumber_i,
    DEVICE        := DEVICE,
    INDEX         := wIndex_i,
    SUBINDEX      := bSubIndex_i,
    ENABLE        := TRUE
    |
    usiDataType_o := DATALENGTH,
    xSuccess_o    := CONFIRM,
    wError_o      := ERROR,
    dwErrorInfo_o := ERRORINFO);

FB_CanSdoRead8 (ENABLE := FALSE);


dwData_o :=             (SHL(BYTE_TO_DWORD(FB_CanSdoRead8.DATA3), 24));
dwData_o := dwData_o OR (SHL(BYTE_TO_DWORD(FB_CanSdoRead8.DATA2), 16));
dwData_o := dwData_o OR (SHL(BYTE_TO_DWORD(FB_CanSdoRead8.DATA1),  8));
dwData_o := dwData_o OR (    BYTE_TO_DWORD(FB_CanSdoRead8.DATA0)     );


RETURN;







END_FUNCTION_BLOCK