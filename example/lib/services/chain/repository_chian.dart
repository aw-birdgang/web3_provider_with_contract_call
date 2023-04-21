import 'package:dio/dio.dart';

import '../../models/chain.dart';
import '../configure/http_configuration_provider.dart';
import '../log/custom_logInterceptor.dart';
import 'irepository_chain.dart';

class RepositoryChain implements IrepositoryChain {

  @override
  Future registerChain(Chain request,) async {
    // String api = dotenv.get('API_URL');
    HttpConfigurationProvider provider = HttpConfigurationProvider();
    String api = provider.getBaseApiUrl ();
    String url = '$api/v1/auth/register';
    print('registerClient > url :: ' + url);
    print('registerClient > request.toString() :: ' + request.toString());
    // String apiKey = dotenv.get('API_KEY');
    String apiKey = provider.getApiKey();
    print('registerClient > apiKey :: ' + apiKey);
    Dio dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $apiKey';
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) async {
        return handler.next(options); //continue
      },
      onResponse:(response,handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) {
        print('registerClient > error.message :: ' + error.message);
        return  handler.next(error);
      }
    ));
    // dio.interceptors.add(CustomLogInterceptor());
    Response response = await dio.post(url, data: request.toMap());
    return Chain.fromJson(response.data);
  }

  @override
  Future<List<Chain>> getChains() async {
    // String api = dotenv.get('API_URL');
    HttpConfigurationProvider provider = HttpConfigurationProvider();
    String api = provider.getBaseApiUrl();
    String url = '$api/v1/client/admin';
    print('getClients > url :: $url');
    String apiKey = provider.getApiKey();
    print('registerClient > apiKey :: $apiKey');

    Dio dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $apiKey';
    Response response = await dio.get(url, queryParameters: {'take': 12, 'pages': 1});
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        return handler.resolve(Response(requestOptions:options, data:'fake data'));
      },
    ));
    // CustomLog
    dio.interceptors.add(CustomLogInterceptor());
    // var pageTotal = response.data['pageTotal'];
    // var total = response.data['total'];
    var results = response.data['results'];
    // print('getDeposits > pageTotal :: ' + pageTotal.toString() + " , total : " + total);
    List<Chain> clients = (results as List)
        .map((x) => Chain.fromJson(x))
        .toList();
    return clients;
  }

}