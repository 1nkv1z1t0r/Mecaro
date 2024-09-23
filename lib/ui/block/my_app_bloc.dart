import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../decoders/nmea_decoder.dart';
import '../../decoders/ubx_decoder.dart';
import '../../models/decoded_message.dart';

part 'my_app_event.dart';

part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(const MyAppState(decodedMessages: [], isLoading: false)) {
    on<LoadingData>(_onLoadingData);
  }

  FutureOr<void> _onLoadingData(
    LoadingData event,
    Emitter<MyAppState> emit,
  ) async {
    List<DecodedMessage> newDecodedMessages = [];
    emit(const MyAppState(isLoading: true, decodedMessages: []));
    try {
      ByteData fileData = await rootBundle.load('assets/dataset.bin');
      Uint8List fileBytes = fileData.buffer.asUint8List();

      int index = 0;
      while (index < fileBytes.length) {
        DecodedMessage decodedMessage;

        if (_isUBXMessage(fileBytes, index)) {
          int length = _getUBXLength(fileBytes, index);
          if (index + 6 + length <= fileBytes.length) {
            Uint8List payload =
                fileBytes.sublist(index + 6, index + 6 + length);
            String ubxText = UBXDecoder.decodeUBX(
                fileBytes[index + 2], fileBytes[index + 3], payload);
            decodedMessage = DecodedMessage(
                text: ubxText,
                icon: Icons.device_hub,
                type: 'UBX',
                description: 'UBX');
            index += 6 + length;
          } else {
            break;
          }
        } else if (fileBytes[index] == 0x24) {
          int endIndex = fileBytes.indexOf(0x0A, index);
          if (endIndex == -1) break;
          String nmeaMessage =
              String.fromCharCodes(fileBytes.sublist(index, endIndex));
          decodedMessage = NMEADecoder.decodeNMEA(nmeaMessage);
          index = endIndex + 1;
        } else {
          index++;
          continue;
        }

        await Future.delayed(const Duration(seconds: 1));
        newDecodedMessages.add(decodedMessage);
        emit(MyAppState(
            decodedMessages: List.from(newDecodedMessages),
            isLoading: state.isLoading));
      }
    } finally {
      emit(
          MyAppState(isLoading: false, decodedMessages: state.decodedMessages));
    }
  }

  bool _isUBXMessage(Uint8List bytes, int index) {
    return bytes[index] == 0xB5 && bytes[index + 1] == 0x62;
  }

  int _getUBXLength(Uint8List bytes, int index) {
    return bytes[index + 4] + (bytes[index + 5] << 8);
  }
}
