import 'package:calc/database/calcdb.dart';
import 'package:calc/util/value.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/custom_card.dart';
import '../widget/selected_item.dart';
import 'create_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double totalAmount = 0;
  Stream calcDBCombo = CalcDB.instace.getCombo();
  Stream calcDBSingle = CalcDB.instace.getSingle();
  List<Map<String, dynamic>> selectedItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Ovy Calc",
          style: GoogleFonts.chewy(
            letterSpacing: 2,
            textStyle: Theme.of(context).textTheme.headlineSmall,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Selected Items",
                    style: TextStyle(
                      color: primaryTextColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        selectedItem = [];
                        totalAmount = 0;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 10,
                        ),
                        child: Text(
                          "Reset",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: secondaryTextColor,
                                  ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: selectedItem.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SelectedItem(
                          amount: selectedItem[index]["amount"],
                          count: selectedItem[index]["count"],
                          image: selectedItem[index]["image"],
                          name: selectedItem[index]["name"],
                          onTap: () {
                            selectedItem[index]["count"] -= 1;
                            totalAmount -= selectedItem[index]["amount"];
                            if (selectedItem[index]["count"] == 0) {
                              selectedItem.removeAt(index);
                            }
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: selectedItem.length,
                    )
                  : const Center(child: Text("No Data")),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      "Total amount  :  $totalAmount",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: secondaryTextColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, top: 10),
              child: Text(
                "Sets",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            StreamBuilder(
              stream: calcDBCombo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      height: 150,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 20),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CustomCard(
                          text: snapshot.data![index].name,
                          image: snapshot.data![index].image,
                          ontap: () {
                            final selectedItemIndex = selectedItem.indexWhere(
                                (item) =>
                                    item["name"] == snapshot.data![index].name);

                            if (selectedItemIndex != -1) {
                              // If the item is already in selectedItem, increment its count
                              selectedItem[selectedItemIndex]["count"]++;
                            } else {
                              // If the item is not in selectedItem, add it
                              selectedItem.add({
                                "amount": snapshot.data![index].amount,
                                "name": snapshot.data![index].name,
                                "image": snapshot.data![index].image,
                                "count": 1,
                              });
                            }
                            totalAmount += snapshot.data![index].amount;
                            setState(() {});
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
              child: Text(
                "Single Piece",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            StreamBuilder(
              stream: calcDBSingle,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      height: 150,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 20),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CustomCard(
                          text: snapshot.data![index].name,
                          image: snapshot.data![index].image,
                          ontap: () {
                            final selectedItemIndex = selectedItem.indexWhere(
                                (item) =>
                                    item["name"] == snapshot.data![index].name);

                            if (selectedItemIndex != -1) {
                              // If the item is already in selectedItem, increment its count
                              selectedItem[selectedItemIndex]["count"]++;
                            } else {
                              // If the item is not in selectedItem, add it
                              selectedItem.add({
                                "amount": snapshot.data![index].amount,
                                "name": snapshot.data![index].name,
                                "image": snapshot.data![index].image,
                                "count": 1,
                              });
                            }
                            totalAmount += snapshot.data![index].amount;
                            setState(() {});
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Material(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 5,
            color: Colors.white.withOpacity(.9),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateCard()));
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.add,
              size: 30,
              color: secondaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
