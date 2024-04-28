// To parse this JSON data, do
//
//     final weatherForcastResponseModel = weatherForcastResponseModelFromJson(jsonString);

import 'dart:convert';

WeatherForcastResponseModel weatherForcastResponseModelFromJson(String str) => WeatherForcastResponseModel.fromJson(json.decode(str));

String weatherForcastResponseModelToJson(WeatherForcastResponseModel data) => json.encode(data.toJson());

class WeatherForcastResponseModel {
    final String? cod;
    final double? message;
    final double? cnt;
    final List<WeatherElement>? list;
    final City? city;

    WeatherForcastResponseModel({
        this.cod,
        this.message,
        this.cnt,
        this.list,
        this.city,
    });

    factory WeatherForcastResponseModel.fromJson(Map<String, dynamic> json) => WeatherForcastResponseModel(
        cod: json["cod"],
        message: json["message"].toDouble(),
        cnt: json["cnt"].toDouble(),
        list: json["list"] == null ? [] : List<WeatherElement>.from(json["list"]!.map((x) => WeatherElement.fromJson(x))),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
    );

    Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "city": city?.toJson(),
    };
}

class City {
    final double? id;
    final String? name;
    final Coord? coord;
    final String? country;
    final double? population;
    final double? timezone;
    final double? sunrise;
    final double? sunset;

    City({
        this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"]?.toDouble(),
        name: json["name"],
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"]?.toDouble(),
        timezone: json["timezone"].toDouble(),
        sunrise: json["sunrise"].toDouble(),
        sunset: json["sunset"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord?.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Coord {
    final double? lat;
    final double? lon;

    Coord({
        this.lat,
        this.lon,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
    };
}

class WeatherElement {
    final double? dt;
    final Main? main;
    final List<Weather>? weather;
    final Clouds? clouds;
    final Wind? wind;
    final double? visibility;
    final double? pop;
    final Sys? sys;
    final DateTime? dtTxt;

    WeatherElement({
        this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.visibility,
        this.pop,
        this.sys,
        this.dtTxt,
    });

    factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        dt: json["dt"]?.toDouble(),
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        visibility: json["visibility"]?.toDouble(),
        pop: json["pop"].toDouble(),
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main?.toJson(),
        "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "clouds": clouds?.toJson(),
        "wind": wind?.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys?.toJson(),
        "dt_txt": dtTxt?.toIso8601String(),
    };
}

class Clouds {
    final double? all;

    Clouds({
        this.all,
    });

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class Main {
    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final double? pressure;
    final double? seaLevel;
    final double? grndLevel;
    final double? humidity;
    final double? tempKf;

    Main({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf,
    });

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"]?.toDouble(),
        seaLevel: json["sea_level"]?.toDouble(),
        grndLevel: json["grnd_level"]?.toDouble(),
        humidity: json["humidity"]?.toDouble(),
        tempKf: json["temp_kf"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
    };
}

class Sys {
    final String? pod;

    Sys({
        this.pod,
    });

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"],
    );

    Map<String, dynamic> toJson() => {
        "pod": pod,
    };
}

class Weather {
    final double? id;
    final String? main;
    final String? description;
    final String? icon;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"]?.toDouble(),
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    final double? speed;
    final double? deg;
    final double? gust;

    Wind({
        this.speed,
        this.deg,
        this.gust,
    });

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"]?.toDouble(),
        gust: json["gust"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}
