
// class OcassionsListInsideMap {
//   const OcassionsListInsideMap({required this.ocassionsList});
//   final List<Map> ocassionsList;
// }

// const OcassionsListInsideMap ocassionsList=  OcassionsListInsideMap(ocassionsList:[{}] );


//initialization in order to not be null at any instance
const Map<String, dynamic> dummyData = {
  "occasions": [{}],
};


//initialization in order to not be null at any instance
const Map dummyExtra = {
  "total_count": 0,
  "page_number": 0,
  "page_size": 0,
};

class OcassionListResponseBody {
  OcassionListResponseBody({
    this.message = "Success",
    //defaut initialization in order to not be null at any instance
    this.data = dummyData,
    this.extra = dummyExtra,
  });

  final String message;
  Map<String, dynamic> data;
  Map extra;
}

// Map ocassionListResponseBody_Example= {
//   "message": "Success",
//   "data": {
//     "occasions": [
//       {
//         "id": 2,
//         "name": "Valentine's Day",
//         "status": "active",
//         "datetime": "2024-02-14T15:16:00.000Z",
//         "send_reminder": false,
//         "reminder_days": 0,
//         "repetition_type": "yearly",
//         "icon": "",
//         "banner": "",
//         "description": "Valentine's Day",
//         "occasion_type": {
//           "id": 2,
//           "name": "Valentine's Day",
//           "icon":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/bSApBJNBcS3C53dfjTckxg_1676373836.png",
//           "banner":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/8YX2AgNTqjcImsVMq6Lh6Q_1676204915.png",
//           "description": "Express your affection with a suitable gift"
//         }
//       }
//     ]
//   },
//   "extra": {
//           "total_count": 1,
//           "page_number": 1,
//           "page_size": 10,
// }
// };

  //       {
//         "id": 2,
//         "name": "Valentine's Day",
//         "status": "active",
//         "datetime": "2024-02-14T15:16:00.000Z",
//         "send_reminder": false,
//         "reminder_days": 0,
//         "repetition_type": "yearly",
//         "icon": "",
//         "banner": "",
//         "description": "Valentine's Day",
//         "occasion_type": {
//           "id": 2,
//           "name": "Valentine's Day",
//           "icon":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/bSApBJNBcS3C53dfjTckxg_1676373836.png",
//           "banner":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/8YX2AgNTqjcImsVMq6Lh6Q_1676204915.png",
//           "description": "Express your affection with a suitable gift"
//         }
//       }

