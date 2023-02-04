import 'apiRockets.dart';

void main() {
  var rockets = fetchLaunch();
  print((rockets.then((rocket) {
    for (var rock in rocket) {
      print("name: ${rock.name}");
      print("mission: ${rock.mission}");
      print("empire: ${rock.empire}");
      print("location: ${rock.empire}");
      print("date: ${rock.date}");
      print("hour: ${rock.hour}");
      print('\n');
    }
  })));
}
