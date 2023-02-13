import 'package:flutter_spotify_ui/common/helper/graphql_helper.dart';
import 'package:flutter_spotify_ui/common/spotify_api/model/library.dart';
import 'package:flutter_spotify_ui/common/spotify_api/model/playlist.dart';
import 'package:graphql/client.dart';

class SpotifyApi {
  const SpotifyApi({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  Future<List<Library>> getAllLibraries() async {
    return graphqlHelper(
      client: _client,
      query: '''
        query getAllLibraries {
          allLibraries {
            id
            title
          }
        }
      ''',
      resultParser: (data) => AllLibraries.fromJson(data).allLibraries,
    );
  }

  Future<List<Playlist>> getAllPlaylists() async {
    return graphqlHelper(
      client: _client,
      query: '''
        query getAllPlaylists {
          allPlaylists {
            id
            name
            imageURL
            name
            description
            creator
            duration
            followers
            PlaylistsSongs {
              Song {
                id
                title
                artist
                album
                duration
              }
            }
          }
        }
      ''',
      resultParser: (data) => AllPlaylists.fromJson(data).allPlaylists,
    );
  }

  Future<Playlist> getPlaylist({required String id}) async {
    return graphqlHelper(
      client: _client,
      query: r'''
        query getPlaylist($id: ID!) {
          Playlist(id: $id) {
            id
            name
            imageURL
            description
            creator
            duration
            followers
            PlaylistsSongs {
              Song {
                id
                title
                artist
                album
                duration
              }
            }
          }
        }
      ''',
      variables: {'id': id},
      resultParser: (data) => Playlist.fromJson(data['Playlist']),
    );
  }
}
