import '../lib/packageName.dart';
import '../lib/models.dart';

void main() async {
  Client client = Client();
  Foo foo = Foo(client);
  Bar bar = Bar(client);
  General general = General(client);

  client.addHeader('Origin', 'http://localhost');
  client.setSelfSigned();

  print('\nTest Started');
  
  // Foo Tests
  Mock response;
  response = await foo.get(x: 'string', y: 123, z: ['string in array']);
  print(response.result);

  response = await foo.post(x: 'string', y: 123, z: ['string in array']);
  print(response.result);

  response = await foo.put(x: 'string', y: 123, z: ['string in array']);
  print(response.result);

  response = await foo.patch(x: 'string', y: 123, z: ['string in array']);
  print(response.result);

  response = await foo.delete(x: 'string', y: 123, z: ['string in array']);
  print(response.result);

  // Bar Tests

  response = await bar.get(xrequired: 'string', xdefault: 123, z: ['string in array']);
  print(response.result);

  response = await bar.post(xrequired: 'string', xdefault: 123, z: ['string in array']);
  print(response.result);

  response = await bar.put(xrequired: 'string', xdefault: 123, z: ['string in array']);
  print(response.result);

  response = await bar.patch(xrequired: 'string', xdefault: 123, z: ['string in array']);
  print(response.result);

  response = await bar.delete(xrequired: 'string', xdefault: 123, z: ['string in array']);
  print(response.result);

  // General Tests

  final res = await general.redirect();
  print(res['result']);

  var file = InputFile(path: '../../resources/file.png',
      filename: 'file.png');
  response = await general.upload(
      x: 'string', y: 123, z: ['string in array'], file: file);
  print(response.result);

  file = InputFile(path: '../../resources/large_file.mp4', filename: 'large_file.mp4');
  response = await general.upload(
      x: 'string', y: 123, z: ['string in array'], file: file);
  print(response.result);

  try {
    await general.error400();
  } on AppwriteException catch (e) {
    print(e.message);
  }

  try {
    await general.error500();
  } on AppwriteException catch (e) {
    print(e.message);
  }

  try {
    await general.error502();
  } on AppwriteException catch (e) {
    print(e.message);
  }

  // response = await general.setCookie();
  // print(response.result);

  // response = await general.getCookie();
  // print(response.result);

  await general.empty();

  // Query helper tests
  print(Query.equal('title', ['Spiderman', 'Dr. Strange']));
  print(Query.notEqual('title', 'Spiderman'));
  print(Query.lesser('releasedYear', 1990));
  print(Query.greater('releasedYear', [1990, 1999]));
  print(Query.search('name', "john"));

  // Permissions, Role and ID helper tests
  print(Permissions.read(Role.any()));
  print(Permissions.write(Role.user(ID.custom('userid'))));
  print(Permissions.create(Role.users()));
  print(Permissions.update(Role.guests()));
  print(Permissions.delete(Role.team('teamId', 'owner')));
  print(Permissions.delete(Role.team('teamId')));
  print(ID.unique());
  print(ID.custom('custom_id'));

}
