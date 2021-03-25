//Copyright 2012 Google
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

part of lawndart;

/// Wraps the local storage API and exposes it as a [Store].
/// Local storage is a synchronous API, and generally not recommended
/// unless all other storage mechanisms are unavailable.
class LocalStorageStore extends Store {
  late SharedPreferences _prefs;

  LocalStorageStore._() : super._();

  /// Open the local storage
  static Future<LocalStorageStore> open() async {
    final Store store = LocalStorageStore._();
    await store._open();
    return store as FutureOr<LocalStorageStore>;
  }

  @override
  Future<void> _open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Stream<String> all() async* {
    for (final key in _prefs.getKeys()) {
      yield _prefs.getString(key)!;
    }
  }

  @override
  Future<void> batch(Map<String, String> objectsByKey) async {
    for (final key in objectsByKey.keys) {
      await _prefs.setString(key, objectsByKey[key]!);
    }
  }

  @override
  Future<bool> exists(String key) async => _prefs.containsKey(key);

  @override
  Future getByKey(String key) async => _prefs.getString(key);

  @override
  Stream<String> getByKeys(Iterable<String> keys) async* {
    for (final key in keys) {
      yield _prefs.getString(key)!;
    }
  }

  @override
  Stream<String> keys() => Stream.fromIterable(_prefs.getKeys());

  @override
  Future<void> nuke() => _prefs.clear();

  @override
  Future<void> removeByKey(String key) => _prefs.remove(key);

  @override
  Future<void> removeByKeys(Iterable<String> keys) async {
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }

  @override
  Future<String> save(String obj, String key) async {
    await _prefs.setString(key, obj);
    return obj;
  }
}
