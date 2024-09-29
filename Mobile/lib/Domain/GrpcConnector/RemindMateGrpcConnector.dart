import 'package:RemindMate/Domain/GrpcConnector/RemindMate.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class RemindMateGrpcConnector {
  // String baseUrl = const String.fromEnvironment("GRPC_BASE_URL",
  //     defaultValue: "54.253.175.109");

  String baseUrl = const String.fromEnvironment("GRPC_BASE_URL",
      defaultValue: "54.253.175.109");
  RemindMateGrpcConnector.internal();

  static final RemindMateGrpcConnector _instance =
      RemindMateGrpcConnector.internal();

  factory RemindMateGrpcConnector() => _instance;

  static RemindMateGrpcConnector get instance => _instance;

  late RemindMateServiceClient _remindMateServiceClient;

  Future<void> init() async {
    _createChannel();
  }

  RemindMateServiceClient get remindMateServiceClient {
    return _remindMateServiceClient;
  }

  _createChannel() {
    final channel = ClientChannel(
      baseUrl,
      port: int.parse(
          const String.fromEnvironment("GPRC_PORT", defaultValue: "9191")),
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _remindMateServiceClient = RemindMateServiceClient(channel);
  }
}
