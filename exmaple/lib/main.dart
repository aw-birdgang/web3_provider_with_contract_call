import 'package:flutter/material.dart';
import 'package:web3/flutter_web3.dart';
import 'package:get/get.dart';

import 'convert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      GetMaterialApp(title: 'Flutter Web3 Example', home: Home());
}

class HomeController extends GetxController {
  bool get isInOperatingChain => currentChain == OPERATING_CHAIN;

  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  String currentAddress = '';

  int currentChain = -1;

  bool wcConnected = false;

  static const OPERATING_CHAIN = SEPOLIA_CHAIN_ID;

  final wc = WalletConnectProvider.binance();

  Web3Provider? web3wc;

  static const SEPOLIA_RPC = "https://sepolia.infura.io/v3/a9829e96d2274a24815abf08f981ae32";
  static const GPEX_RPC = "https://rpc.gpexdev.com";
  static const SEPOLIA_CHAIN_ID = 11155111;
  static const GPEX_CHAIN_ID = 1;


  connectProvider() async {
    if (Ethereum.isSupported) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
        currentChain = await ethereum!.getChainId();
      }

      update();
    }
  }

  connectWC() async {
    await wc.connect();
    if (wc.connected) {
      currentAddress = wc.accounts.first;
      currentChain = 1;
      wcConnected = true;
      web3wc = Web3Provider.fromWalletConnect(wc);
    }

    update();
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    wcConnected = false;
    web3wc = null;

    update();
  }

  init() {
    if (Ethereum.isSupported) {
      connectProvider();

      ethereum!.onAccountsChanged((accs) {
        clear();
      });

      ethereum!.onChainChanged((chain) {
        clear();
      });
    }
  }

  getLastestBlock() async {
    print(await provider!.getLastestBlock());
    print(await provider!.getLastestBlockWithTransaction());
    print(await provider!.getBalance("0x6A1375E47E402cd71EB5C7Db807c152886fe9045"));
  }

  contract() async {
    ContractERC20 contractERC20 = new ContractERC20("0x87c6775b40A4a6f10aeBBaF3adEa443dE091b361", provider!.getSigner());
    print(await contractERC20!.name);
    print(await contractERC20!.totalSupply);
    print(await contractERC20!.symbol);
  }

  mint() async {
    ContractERC20 contractERC20 = new ContractERC20("0x87c6775b40A4a6f10aeBBaF3adEa443dE091b361", provider!.getSigner());
    var value = convertAmountToEtherToken("20");
    print(value);
    TransactionResponse response = await contractERC20!.mint("0x6A1375E47E402cd71EB5C7Db807c152886fe9045", value);
    print(response.hash);
  }

  burn() async {
    ContractERC20 contractERC20 = new ContractERC20("0x87c6775b40A4a6f10aeBBaF3adEa443dE091b361", provider!.getSigner());
    var value = convertAmountToEtherToken("20");
    print(value);
    TransactionResponse response = await contractERC20!.burn(value);
    print(response.hash);
  }

  transfer() async {
    ContractERC20 contractERC20 = new ContractERC20("0x87c6775b40A4a6f10aeBBaF3adEa443dE091b361", provider!.getSigner());
    var value = convertAmountToEtherToken("20");
    print(value);
    TransactionResponse response = await contractERC20!.transfer("0x2B4e2a3D3B20eff91A40C1759fa50A0E2250314F", value);
    print(response.hash);
  }

  testProvider() async {
    final rpcProvider = JsonRpcProvider(SEPOLIA_RPC);
    print(rpcProvider);
    print(await rpcProvider.getNetwork());
  }

  test() async {}

  testSwitchChain() async {
    await ethereum!.walletSwitchChain(100, () async {
      await ethereum!.walletAddChain(
        chainId: 1,
        chainName: 'GPEX MAINNET',
        nativeCurrency:
        CurrencyParams(name: 'GPX', symbol: 'GPX', decimals: 18),
        rpcUrls: [],
      );
    });
  }

  @override
  void onInit() {
    // init();
    super.onInit();
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (h) => Scaffold(
        // log("h.isConnected.toString() : " + h.isConnected.toString());
        body: Center(
          child: Column(children: [
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wallet Connect : ${h.wcConnected}'),
                Container(width: 10),
                OutlinedButton(
                    child: Text('Connect Wallet'), onPressed:() {
                  h.init();
                })
              ],
            ),
            Container(height: 10),
            Builder(builder: (_) {
              var shown = '';
              if (h.isConnected && h.isInOperatingChain)
                shown = 'You\'re connected!';
              else if (h.isConnected && !h.isInOperatingChain)
                shown = 'Wrong chain! Please connect to Chain.';
              // else if (Ethereum.isSupported)
              //   return OutlinedButton(
              //       child: Text('Connect'), onPressed: h.connectProvider);
              else
                shown = 'Your browser is not supported!' + h.isConnected.toString();

              return Text(shown,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
            }),
            Container(height: 30),
            if (h.isConnected && h.isInOperatingChain) ...[
              TextButton(
                  onPressed: h.getLastestBlock,
                  child: Text('get lastest block')),
              Container(height: 10),
              TextButton(
                  onPressed: h.contract,
                  child: Text('get contract info')),
              Container(height: 10),
              TextButton(
                  onPressed: h.mint,
                  child: Text('mint')),
              Container(height: 10),
              TextButton(
                  onPressed: h.burn,
                  child: Text('burn')),
              Container(height: 10),
              TextButton(
                  onPressed: h.transfer,
                  child: Text('transfer')),
              Container(height: 10),
              TextButton(
                  onPressed: h.testProvider,
                  child: Text('test rpc provider')),
              Container(height: 10),
              TextButton(onPressed: h.test, child: Text('test')),
              Container(height: 10),
              TextButton(
                  onPressed: h.testSwitchChain,
                  child: Text('test switch chain')),
            ],
            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wallet Connect connected: ${h.wcConnected}'),
                Container(width: 10),
                OutlinedButton(
                    child: Text('Connect to WC'), onPressed: h.connectWC)
              ],
            ),
            Container(height: 30),
            if (h.wcConnected && h.wc.connected) ...[
              Text(h.wc.walletMeta.toString()),
            ],
          ]),
        ),
      ),
    );
  }
}