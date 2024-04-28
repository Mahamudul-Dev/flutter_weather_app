// To parse this JSON data, do
//
//     final currentWeatherModelResponseModel = currentWeatherModelResponseModelFromJson(jsonString);

import 'dart:convert';

CurrentWeatherResponseModel currentWeatherModelResponseModelFromJson(String str) => CurrentWeatherResponseModel.fromJson(json.decode(str));

String currentWeatherModelResponseModelToJson(CurrentWeatherResponseModel data) => json.encode(data.toJson());

class CurrentWeatherResponseModel {
    final CoordModel? coord;
    final List<WeatherModel>? weather;
    final String? base;
    final MainWeatherModel? main;
    final double? visibility;
    final WindModel? wind;
    final CloudsModel? clouds;
    final double? dt;
    final SysModel? sys;
    final double? timezone;
    final double? id;
    final String? name;
    final double? cod;

    CurrentWeatherResponseModel({
        this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod,
    });

    factory CurrentWeatherResponseModel.fromJson(Map<String, dynamic> json) => CurrentWeatherResponseModel(
        coord: json["coord"] == null ? null : CoordModel.fromJson(json["coord"]),
        weather: json["weather"] == null ? [] : List<WeatherModel>.from(json["weather"]!.map((x) => WeatherModel.fromJson(x))),
        base: json["base"],
        main: json["main"] == null ? null : MainWeatherModel.fromJson(json["main"]),
        visibility: json["visibility"]?.toDouble(),
        wind: json["wind"] == null ? null : WindModel.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : CloudsModel.fromJson(json["clouds"]),
        dt: json["dt"]?.toDouble(),
        sys: json["sys"] == null ? null : SysModel.fromJson(json["sys"]),
        timezone: json["timezone"]?.toDouble(),
        id: json["id"]?.toDouble(),
        name: json["name"],
        cod: json["cod"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "coord": coord?.toJson(),
        "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "base": base,
        "main": main?.toJson(),
        "visibility": visibility,
        "wind": wind?.toJson(),
        "clouds": clouds?.toJson(),
        "dt": dt,
        "sys": sys?.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
    };
}

class CloudsModel {
    final double? all;

    CloudsModel({
        this.all,
    });

    factory CloudsModel.fromJson(Map<String, dynamic> json) => CloudsModel(
        all: json["all"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class CoordModel {
    final double? lon;
    final double? lat;

    CoordModel({
        this.lon,
        this.lat,
    });

    factory CoordModel.fromJson(Map<String, dynamic> json) => CoordModel(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class MainWeatherModel {
    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final double? pressure;
    final double? humidity;
    final double? seaLevel;
    final double? grndLevel;

    MainWeatherModel({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel,
    });

    factory MainWeatherModel.fromJson(Map<String, dynamic> json) => MainWeatherModel(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"]?.toDouble(),
        humidity: json["humidity"]?.toDouble(),
        seaLevel: json["sea_level"]?.toDouble(),
        grndLevel: json["grnd_level"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
    };
}

class SysModel {
    final String? country;
    final double? sunrise;
    final double? sunset;

    SysModel({
        this.country,
        this.sunrise,
        this.sunset,
    });

    factory SysModel.fromJson(Map<String, dynamic> json) => SysModel(
        country: json["country"],
        sunrise: json["sunrise"]?.toDouble(),
        sunset: json["sunset"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class WeatherModel {
    final int? id;
    final String? main;
    final String? description;
    final String? icon;

    WeatherModel({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        id: json["id"],
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

class WindModel {
    final double? speed;
    final double? deg;
    final double? gust;

    WindModel({
        this.speed,
        this.deg,
        this.gust,
    });

    factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
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
