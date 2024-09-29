import 'package:RemindMate/Domain/GrpcConnector/Message.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ExampleGrpcConnector {
  String baseUrl = const String.fromEnvironment("GRPC_BASE_URL",
      defaultValue: "54.253.175.109");
  ExampleGrpcConnector.internal();

  static final ExampleGrpcConnector _instance = ExampleGrpcConnector.internal();

  factory ExampleGrpcConnector() => _instance;

  static ExampleGrpcConnector get instance => _instance;

  late ExampleServiceClient _exampleServiceClient;

  Future<void> init() async {
    _createChannel();
  }

  ExampleServiceClient get exampleServiceClient {
    return _exampleServiceClient;
  }

  _createChannel() {
    final channel = ClientChannel(
      baseUrl,
      port: int.parse(
          const String.fromEnvironment("GPRC_PORT", defaultValue: "9191")),
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _exampleServiceClient = ExampleServiceClient(channel);
  }
}
