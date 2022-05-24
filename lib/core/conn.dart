import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

const SUPABASE_URL = 'https://ictzqjunksylhjgfmqih.supabase.co';
const SUPABASE_ANNON_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljdHpxanVua3N5bGhqZ2ZtcWloIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTMzMDMwMjYsImV4cCI6MTk2ODg3OTAyNn0.Zil-lWWOrrRmJY7Rln5gUq1Nupp3ghgutMInVsG0fh0';
const SERVICE_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljdHpxanVua3N5bGhqZ2ZtcWloIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY1MzMwMzAyNiwiZXhwIjoxOTY4ODc5MDI2fQ.Gvg1LAaIb5Nwth4FS1UvcXlEaXWe0s61NcWwMWvrdqs';

String? accessToken;

final supabase = SupabaseClient(SUPABASE_URL, SERVICE_KEY);

Future<dynamic> supabaseRequest(Future<dynamic> service) async {
  final res = await service;
  if (res.error != null) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      snackbar(
        scaffoldMessengerKey.currentContext!,
        backgroundColor: Colors.red,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(
                res.error!.message,
                // overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
            ],
          ),
        ),
      ),
    );
  }
  return res;
}
