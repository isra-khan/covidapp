import 'dart:core';
import 'package:covidapp/constant/responsive_config.dart';
import 'package:covidapp/view/widgets/resuablerow_widget.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int active;
  final int critical;
  final int todayRecovered;
  final int test;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).width * 0.04,
            vertical: Responsive(context).height * 0.03,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.name),
      centerTitle: true,
    );
  }

  ///  Body
  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildStatsCard(context),
            _buildAvatar(),
          ],
        ),
      ],
    );
  }

  /// 🧱 Avatar Image
  Widget _buildAvatar() {
    return Positioned(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(widget.image),
      ),
    );
  }

  /// 🧱 Stats Card
  Widget _buildStatsCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
      child: Card(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .06),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  /// 🧱 Rows inside the card
  Widget _buildStats() {
    return Column(
      children: [
        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
        ReusableRow(
            title: 'Recovered', value: widget.totalRecovered.toString()),
        ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
        ReusableRow(title: 'Critical', value: widget.critical.toString()),
        ReusableRow(
            title: 'Today Recovered', value: widget.todayRecovered.toString()),
        ReusableRow(title: 'Tests', value: widget.test.toString()),
        ReusableRow(title: 'Active', value: widget.active.toString()),
      ],
    );
  }
}
