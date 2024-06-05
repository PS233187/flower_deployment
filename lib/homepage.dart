import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:eindopdracht/model/flower_model.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';
import 'scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<FlowerModel> main_flower_list = [
    FlowerModel('Rose', 'native',
        'https://images.unsplash.com/photo-1473972908677-002f6404ac82?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
    FlowerModel('Sunflower', 'Magnoliophyta',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Iglesia_de_Nuestra_Se%C3%B1ora_de_La_Blanca%2C_Cardej%C3%B3n%2C_Espa%C3%B1a%2C_2012-09-01%2C_DD_02_cropped.JPG/1920px-Iglesia_de_Nuestra_Se%C3%B1ora_de_La_Blanca%2C_Cardej%C3%B3n%2C_Espa%C3%B1a%2C_2012-09-01%2C_DD_02_cropped.JPG'),
    FlowerModel('Daliah', 'Oleaceae',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Dahlia_-_roze.jpg/399px-Dahlia_-_roze.jpg'),
    FlowerModel('Jasmine', 'Magnoliophyta',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Common_Jasmine.jpg/1024px-Common_Jasmine.jpg'),
    FlowerModel('marigold', 'Asteraceae',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Tagetes_erecta_chendumalli_chedi.jpg/800px-Tagetes_erecta_chendumalli_chedi.jpg'),
    FlowerModel('Violet', 'Violaceae',
        'https://upload.wikimedia.org/wikipedia/commons/3/3a/5p_pwy_pansies.jpg'),
  ];

  List<FlowerModel> display_list = List.from(main_flower_list);

  void updateList(String value) {
    setState(() {
      display_list = main_flower_list
          .where((element) =>
          element.flower_name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  final List<Widget> _pages = [
    // HOMEPAGE
    Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Jazzies Flowers: HOME'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/bloem1.png'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Welkom bij Jazzies Flowers!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ontdek de mooiste bloemen hier.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    // SEARCHPAGE
    Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          // Pas de achtergrondkleur van de app bar aan
          title: Text(
              'Jazzies Flowers: SEARCH'), // Pas de titel van de app bar aan
        ),
        body: Center(
          child: Image(
            image: AssetImage('images/bloem2.png'),
          ),
        ),
      ),
    ),

    // ABOUTPAGE
    Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green, // Pas de achtergrondkleur van de app bar aan
          title: Text('Jazzies Flowers: ABOUT'), // Pas de titel van de app bar aan
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? _questionPage()
          : _selectedIndex == 1
          ? _flowerSearchPage()
          : _licensesPage(context),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.settings,
                text: 'About',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Jazzies Flowers: HOME'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/bloem1.png'),
              width: 200,
              height: 280,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Welkom bij Jazzies Flowers!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ontdek de mooiste bloemen hier.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // searchPagina
  Widget _flowerSearchPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Jazzies Flowers: Search'),
        scrolledUnderElevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code), // QR-code scan icoon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRCodeScannerPage()), // Navigeer naar QRCodeScannerPage
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search for a flower',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MultiTriggerAutocomplete(
              // optionsAlignment: OptionsAlignment.topStart,
              autocompleteTriggers: [
                AutocompleteTrigger(
                  trigger: '@',
                  optionsViewBuilder: (context, autocompleteQuery, controller) {
                    return MentionAutocompleteOptions(
                      query: autocompleteQuery.query,
                      onMentionFlowerTap: (flowerModel) {
                        final autocomplete = MultiTriggerAutocomplete.of(context);
                        return autocomplete.acceptAutocompleteOption(flowerModel);
                      },
                    );
                  },
                ),
              ],
              fieldViewBuilder: (context, controller, focusNode) {
                return TextField(
                  focusNode: focusNode,
                  controller: controller,
                  onChanged: (value) => updateList(value),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'eg: Sunflowers',
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.white,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: display_list.isEmpty
                  ? Center(
                child: Text(
                  "no flowers found",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  title: Text(
                    display_list[index].flower_name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${display_list[index].flower_family!}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  leading: Image.network(
                    display_list[index].flower_poster_url!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // licensesPagina
  Widget _licensesPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Jazzies Flowers: ABOUT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/bloem1.png'),
            ),
            ElevatedButton(
              onPressed: () => aboutMyApp(context), // Hier wordt de BuildContext doorgegeven
              child: Text('view Licenses'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void aboutMyApp(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: FlutterLogo(),
      applicationName: 'About page App',
      applicationVersion: '0.0.1',
      applicationLegalese: 'DEVELOPED BY JAZZIE',
      children: <Widget>[
        SizedBox(height: 20),
        Text(
            'The app development process involved meticulous planning, design, coding, and testing. Appropriate licenses were selected, including open-source, commercial, and proprietary licenses, and license agreements were drafted to ensure legal compliance and protect intellectual property.'),
      ],
    );
  }

  Widget MentionAutocompleteOptions(
      {required String query,
        required void Function(String flower) onMentionFlowerTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onMentionFlowerTap('Rose');
          },
          child: Text('Native'),
        ),
        GestureDetector(
          onTap: () {
            onMentionFlowerTap('Sunflower');
          },
          child: Text('Native'),
        ),
      ],
    );
  }
}
