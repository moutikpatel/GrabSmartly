import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeWebInstructionScreen extends StatefulWidget {
  String url;
  String title;
  RecipeWebInstructionScreen({required this.url, required this.title});


  @override
  _RecipeWebInstructionScreenState createState() => _RecipeWebInstructionScreenState();
}

class _RecipeWebInstructionScreenState extends State<RecipeWebInstructionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is widget.mealType
      appBar: AppBar(
          title: Text(widget.title, style: Theme.of(context).textTheme.headlineSmall,),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFFB0D9B1),
      ),
      /**
       * Body is a Webview. Ensure you have imported webview flutter.
       *
       * initialUrl- spoonacularSourceUrl of our parsed in recipe
       * javascriptMode - set to unrestricted so as JS can load in the webview
       */
      body: WebView(
        initialUrl: widget.url,
        //JS unrestricted, so that JS can execute in the webview
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}