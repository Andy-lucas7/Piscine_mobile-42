// Arquivo: lib/services/location_service.dart
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  /// Verifica se o serviço de localização está habilitado e com permissões
  /// 
  /// Retorna [true] se a localização estiver habilitada e com permissões
  /// Retorna [false] caso contrário
  Future<bool> isLocationEnabled() async {
    // Verifica se o serviço de localização está ativado
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      // Tenta ativar o serviço
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    
    // Verifica permissões
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      // Solicita permissão
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    
    return true;
  }

  /// Obtém a localização atual do dispositivo
  /// 
  /// Retorna um objeto [LocationData] com as coordenadas
  /// Retorna [null] caso não tenha permissão ou o serviço esteja desabilitado
  Future<LocationData?> getCurrentLocation() async {
    if (await isLocationEnabled()) {
      return await _location.getLocation();
    }
    return null;
  }
}