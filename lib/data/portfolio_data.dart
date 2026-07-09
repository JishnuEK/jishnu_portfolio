import 'dart:convert';
import 'package:flutter/services.dart';
class ContactData {
  final String type;
  final String title;
  final String subtitle;
  final String url;
  const ContactData({required this.type, required this.title, required this.subtitle, required this.url});

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      type: json['type'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      url: json['url'] as String,
    );
  }
}

class FooterLink {
  final String label;
  final String url;
  const FooterLink({required this.label, required this.url});

  factory FooterLink.fromJson(Map<String, dynamic> json) {
    return FooterLink(
      label: json['label'] as String,
      url: json['url'] as String,
    );
  }
}

class FooterData {
  final String copyright;
  final List<FooterLink> links;
  const FooterData({required this.copyright, required this.links});

  factory FooterData.fromJson(Map<String, dynamic> json) {
    return FooterData(
      copyright: json['copyright'] as String,
      links: (json['links'] as List).map((i) => FooterLink.fromJson(i)).toList(),
    );
  }
}

class HeroData {
  final String name;
  final String role;
  final List<String> description;
  const HeroData({required this.name, required this.role, required this.description});

  factory HeroData.fromJson(Map<String, dynamic> json) {
    return HeroData(
      name: json['name'] as String,
      role: json['role'] as String,
      description: List<String>.from(json['description']),
    );
  }
}

class Education {
  final String degree;
  final String institution;
  final String duration;
  final List<String> courses;
  const Education({required this.degree, required this.institution, required this.duration, required this.courses});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      duration: json['duration'] as String,
      courses: List<String>.from(json['courses']),
    );
  }
}

class Experience {
  final String title;
  final String company;
  final String duration;
  final List<String> description;
  const Experience({required this.title, required this.company, required this.duration, required this.description});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] as String,
      company: json['company'] as String,
      duration: json['duration'] as String,
      description: List<String>.from(json['description']),
    );
  }
}

class Project {
  final String title;
  final String? subtitle;
  final List<String> description;
  final List<String> points;
  final List<String> techStack;
  final String? playStoreLink;
  final String? appStoreLink;
  const Project({required this.title, this.subtitle, required this.description, required this.points, required this.techStack, this.playStoreLink, this.appStoreLink});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: List<String>.from(json['description'] ?? []),
      points: List<String>.from(json['points'] ?? []),
      techStack: List<String>.from(json['techStack'] ?? []),
      playStoreLink: json['playStoreLink'] as String?,
      appStoreLink: json['appStoreLink'] as String?,
    );
  }
}

class PortfolioData {
  static Future<List<String>> getSkills() async {
    final String response = await rootBundle.loadString('assets/data/skills.json');
    final List<dynamic> data = json.decode(response);
    return data.cast<String>();
  }

  static Future<HeroData> getHeroData() async {
    final String response = await rootBundle.loadString('assets/data/hero.json');
    final Map<String, dynamic> data = json.decode(response);
    return HeroData.fromJson(data);
  }

  static Future<List<Education>> getEducation() async {
    final String response = await rootBundle.loadString('assets/data/education.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Education.fromJson(json)).toList();
  }

  static Future<List<Experience>> getExperience() async {
    final String response = await rootBundle.loadString('assets/data/experience.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Experience.fromJson(json)).toList();
  }

  static Future<List<Project>> getProjects() async {
    final String response = await rootBundle.loadString('assets/data/projects.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Project.fromJson(json)).toList();
  }

  static Future<FooterData> getFooterData() async {
    final String response = await rootBundle.loadString('assets/data/footer.json');
    final Map<String, dynamic> data = json.decode(response);
    return FooterData.fromJson(data);
  }

  static Future<List<ContactData>> getContactData() async {
    final String response = await rootBundle.loadString('assets/data/contact.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => ContactData.fromJson(json)).toList();
  }

  static Future<List<String>> getAboutMe() async {
    final String response = await rootBundle.loadString('assets/data/about.json');
    final List<dynamic> data = json.decode(response);
    return data.cast<String>();
  }
}

