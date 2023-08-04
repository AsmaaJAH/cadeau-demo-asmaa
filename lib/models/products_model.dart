//  ------------------------ show single product details api ----------------------------
//initialization in order to not be null at any instance
const Map dummyData = {
  "product": {},
};



class OneProductdetailsResponseBody {
  OneProductdetailsResponseBody({
    this.message = "Success",
    //defaut initialization in order to not be null at any instance
    this.data = dummyData,
  });

  final String message;
  Map data;
}


// const Map shoesExample = {
//   "message": "Success",
//   "data": {
//     "product": {
//       "id": 21,
//       "name": "Air Jordan 1 Mid",
//       "status": "available",
//       "price": 500.0,
//       "price_after_discount": 450.0,
//       "currency": {"id": 1, "name": "SAR", "lookup_key": "SAR"},
//       "is_visible": true,
//       "is_wrappable": false,
//       "in_stock?": true,
//       "avg_rate": 0.0,
//       "reviews_count": 0,
//       "dynamic_link": null,
//       "target_age": "any",
//       "target_gender": "female",
//       "default_variant_id": 68,
//       "image":
//           "https://cadaeu.s3.eu-central-1.amazonaws.com/development/VL5LdwHyUY9ll0gN_nhOaA_1683717294_.png",
//       "master_variant_id": 28,
//       "total_on_hand": 1000,
//       "description":
//           "Inspired by the original AJ1, this mid-top edition maintains the iconic look you love while choice colors and crisp leather give it a distinct identity.\r\n\r\n\r\nBenefits\r\n\r\nLeather, synthetic leather and textile upper for a supportive feel.\r\nFoam midsole and Nike Air cushioning provide lightweight comfort.\r\nRubber outsole with pivot circle gives you durable traction.\r\nColor Shown: Lucky Green/White/Black\r\nCountry/Region of Origin: Indonesia",
//       "media": [
//         {
//           "id": 129,
//           "mediable_type": "Variant",
//           "mediable_id": 28,
//           "media_type": "photo",
//           "file_name": "",
//           "url":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/VL5LdwHyUY9ll0gN_nhOaA_1683717294_.png",
//           "media_option": "default"
//         },
//         {
//           "id": 130,
//           "mediable_type": "Variant",
//           "mediable_id": 28,
//           "media_type": "photo",
//           "file_name": "",
//           "url":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/82iFc2FxOmv-xOt-eKBAYQ_1683717294_.png",
//           "media_option": "default"
//         }
//       ],
//       "store": {
//         "id": 1,
//         "name": "Nike",
//         "logo":
//             "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//         "tags": "Sports"
//       },
//       "option_types": [
//         {
//           "id": 4,
//           "name": "Shoe Size",
//           "option_values": [
//             {"id": 14, "name": "EU 40", "presentation": "EU 40"},
//             {"id": 15, "name": "EU 41", "presentation": "EU 41"},
//             {"id": 16, "name": "EU 42", "presentation": "EU 42"},
//             {"id": 17, "name": "EU 43", "presentation": "EU 43"},
//             {"id": 18, "name": "EU 44", "presentation": "EU 44"}
//           ]
//         }
//       ],
//       "occasion_types": [
//         {
//           "id": 1,
//           "name": "Birthday",
//           "icon":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/wHegCZ522Xn0QNZaVyuQCg_1676204761.png",
//           "banner":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/7kqLEO7umeFb9iH2DH3xhw_1676204819.png",
//           "description": null
//         },
//         {
//           "id": 3,
//           "name": "Anniversary",
//           "icon":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/KEU_CMRUknNL9HGL7te_tg_1676205102.png",
//           "banner":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/WjGcR5S7-uwE9nr4FC-hkA_1676205138.png",
//           "description": null
//         },
//         {
//           "id": 2,
//           "name": "Valentine's Day",
//           "icon":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/bSApBJNBcS3C53dfjTckxg_1676373836.png",
//           "banner":
//               "https://cadaeu.s3.eu-central-1.amazonaws.com/development/8YX2AgNTqjcImsVMq6Lh6Q_1676204915.png",
//           "description": "Express your affection with a suitable gift"
//         }
//       ],
//       "created_at": "2023-05-10T14:14:54.580+03:00",
//       "updated_at": "2023-07-18T15:23:22.993+03:00"
//     }
//   }
// };
/// Map example_2={
//     "message": "Success",
//     "data": {
//         "product": {
//             "id": 1,
//             "name": "Shoes",
//             "status": "available",
//             "price": 1000.0,
//             "price_after_discount": 800.0,
      //             "currency": {
      //                 "id": 1,
      //                 "name": "SAR",
      //                 "lookup_key": "SAR"
      //             },
//             "is_visible": true,
//             "is_wrappable": false,
//             "in_stock?": true,
//             "avg_rate": 5.0,
//             "reviews_count": null,
//             "dynamic_link": null,
//             "target_age": null,
//             "target_gender": null,
//             "default_variant_id": 2,
//             "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/U2HD07GryJWeELpQP7MjpA_1678354874_.png",
//             "master_variant_id": 1,
//             "total_on_hand": 600,
//             "description": "This is a bag.",
//             "media": [
//                 {
//                     "id": 1,
//                     "mediable_type": "Variant",
//                     "mediable_id": 1,
//                     "media_type": "photo",
//                     "file_name": "",
//                     "url": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/U2HD07GryJWeELpQP7MjpA_1678354874_.png",
//                     "media_option": "default"
//                 },
//                 {
//                     "id": 11,
//                     "mediable_type": "Variant",
//                     "mediable_id": 1,
//                     "media_type": "photo",
//                     "file_name": "",
//                     "url": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/FTJHmU-tAK2ntUhrxGqV1g_1679309509_.png",
//                     "media_option": "default"
//                 }
//             ],
//             "store": {
//                 "id": 1,
//                 "name": "Nike",
//                 "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                 "tags": "Sports"
//             },
//             "option_types": [
//                 {
//                     "id": 2,
//                     "name": "Color",
//                     "option_values": [
        //                         {
        //                             "id": 20,
        //                             "name": "Havan",
        //                             "presentation": "#dcab50"
        //                         },
        //                         {
        //                             "id": 8,
        //                             "name": "Rose",
        //                             "presentation": "#FF007F"
        //                         },
        //                         {
        //                             "id": 19,
        //                             "name": "Grey",
        //                             "presentation": "#808080"
        //                         },
        //                         {
        //                             "id": 9,
        //                             "name": "White",
        //                             "presentation": "#FFFFFF"
        //                         },
        //                         {
        //                             "id": 7,
        //                             "name": "Blue",
        //                             "presentation": "#0000FF"
        //                         },
        //                         {
        //                             "id": 2,
        //                             "name": "Black",
        //                             "presentation": "#000000"
        //                         },
        //                         {
        //                             "id": 1,
        //                             "name": "Red",
        //                             "presentation": "#FF0000"
        //                         }
        //                     ]
//                 },
//                 {
//                     "id": 3,
//                     "name": "Size",
                //                     "option_values": [
                //                         {
                //                             "id": 3,
                //                             "name": "Small",
                //                             "presentation": "Small"
                //                         },
                //                         {
                //                             "id": 4,
                //                             "name": "Medium",
                //                             "presentation": "Medium"
                //                         },
                //                         {
                //                             "id": 5,
                //                             "name": "Large",
                //                             "presentation": "Large"
                //                         }
                //                     ]
//                 }
//             ],
//             "occasion_types": [],
//             "created_at": "2023-03-06T11:34:37.514+02:00",
//             "updated_at": "2023-07-24T13:14:55.308+03:00"
//         }
//     }
// }






//------------------------------------- products list api -----------------------
//Map SingleProductItem={
//                 "id": 1,
//                 "name": "Shoes",
//                 "status": "available",
//                 "price": 1000.0,
//                 "price_after_discount": 800.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 5.0,
//                 "reviews_count": null,
//                 "dynamic_link": null,
//                 "target_age": null,
//                 "target_gender": null,
//                 "default_variant_id": 2,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/U2HD07GryJWeELpQP7MjpA_1678354874_.png",
//                 "master_variant_id": 1,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             };



//
//
//
//
//
//
// Map productsResponseBody_Example={
//     "message": "Success",
//     "data": {
//         "products": [
//             {
//                 "id": 1,
//                 "name": "Shoes",
//                 "status": "available",
//                 "price": 1000.0,
//                 "price_after_discount": 800.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 5.0,
//                 "reviews_count": null,
//                 "dynamic_link": null,
//                 "target_age": null,
//                 "target_gender": null,
//                 "default_variant_id": 2,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/U2HD07GryJWeELpQP7MjpA_1678354874_.png",
//                 "master_variant_id": 1,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 7,
//                 "name": "Ramdan Bag",
//                 "status": "available",
//                 "price": 800.0,
//                 "price_after_discount": 799.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "any",
//                 "default_variant_id": 55,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/XCtuWxhmVLag_uEfXFRSqg_1683671735_.png",
//                 "master_variant_id": 8,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 25,
//                 "name": "Men's Poly-Knit Tracksuit",
//                 "status": "available",
//                 "price": 700.0,
//                 "price_after_discount": 600.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "male",
//                 "default_variant_id": 70,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/QB7Vs7mQGWmzSZmbDJw9Og_1683720395_.png",
//                 "master_variant_id": 34,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 21,
//                 "name": "Air Jordan 1 Mid",
//                 "status": "available",
//                 "price": 500.0,
//                 "price_after_discount": 450.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "female",
//                 "default_variant_id": 68,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/VL5LdwHyUY9ll0gN_nhOaA_1683717294_.png",
//                 "master_variant_id": 28,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 22,
//                 "name": "Nike Revolution 6 Next Nature Premium",
//                 "status": "available",
//                 "price": 500.0,
//                 "price_after_discount": 450.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "female",
//                 "default_variant_id": 69,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/jH5N3UKiKPIzS8MfWmUTyA_1683718068_.png",
//                 "master_variant_id": 29,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 10,
//                 "name": "Gift Box",
//                 "status": "available",
//                 "price": 600.0,
//                 "price_after_discount": 410.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": false,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "any",
//                 "default_variant_id": 62,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/3JTeMHJGA3-fMw2VMB9Jvg_1680516393_.png",
//                 "master_variant_id": 11,
//                 "store": {
//                     "id": 6,
//                     "name": "M&M",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/LFdWriJjPHHT_eaRljp1gg_1679571455.png",
//                     "tags": "Style"
//                 }
//             },
//             {
//                 "id": 23,
//                 "name": "Nike Sportswear T shirt ",
//                 "status": "available",
//                 "price": 400.0,
//                 "price_after_discount": 400.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "any",
//                 "target_gender": "male",
//                 "default_variant_id": 56,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/Vr1vixIqnYUbcrw_810r_A_1683718445_.png",
//                 "master_variant_id": 30,
//                 "store": {
//                     "id": 1,
//                     "name": "Nike",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/GMrmfs5u9yyrGe-6OtRLzA_1676371912.png",
//                     "tags": "Sports"
//                 }
//             },
//             {
//                 "id": 30,
//                 "name": "Cargo pant",
//                 "status": "available",
//                 "price": 400.0,
//                 "price_after_discount": 400.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "teenagers",
//                 "target_gender": "male",
//                 "default_variant_id": 73,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/lpx3_DZ_tLqTV_S37RT5SQ_1689683590_.png",
//                 "master_variant_id": 41,
//                 "store": {
//                     "id": 2,
//                     "name": "H&M",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/Xz7nh89Om8F4b6WA87tVcw_1675948397.png",
//                     "tags": "Fashion, Style"
//                 }
//             },
//             {
//                 "id": 5,
//                 "name": "Pant ",
//                 "status": "available",
//                 "price": 350.0,
//                 "price_after_discount": 350.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "adults",
//                 "target_gender": "male",
//                 "default_variant_id": 51,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/cwCFGWjlMUeXgjL4e0KSUw_1678875859_.png",
//                 "master_variant_id": 6,
//                 "store": {
//                     "id": 2,
//                     "name": "H&M",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/Xz7nh89Om8F4b6WA87tVcw_1675948397.png",
//                     "tags": "Fashion, Style"
//                 }
//             },
//             {
//                 "id": 6,
//                 "name": "Polo T shirt",
//                 "status": "available",
//                 "price": 320.0,
//                 "price_after_discount": 320.0,
//                 "currency": {
//                     "id": 1,
//                     "name": "SAR",
//                     "lookup_key": "SAR"
//                 },
//                 "is_visible": true,
//                 "is_wrappable": false,
//                 "in_stock?": true,
//                 "avg_rate": 0.0,
//                 "reviews_count": 0,
//                 "dynamic_link": null,
//                 "target_age": "adults",
//                 "target_gender": "male",
//                 "default_variant_id": 43,
//                 "image": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/0uicUUbxxGTBozsJuTPcnA_1678983445_.png",
//                 "master_variant_id": 7,
//                 "store": {
//                     "id": 2,
//                     "name": "H&M",
//                     "logo": "https://cadaeu.s3.eu-central-1.amazonaws.com/development/Xz7nh89Om8F4b6WA87tVcw_1675948397.png",
//                     "tags": "Fashion, Style"
//                 }
//             }
//         ]
//     },
//     "extra": {
//         "total_count": 29,
//         "page_number": 1,
//         "page_size": 10
//     }
// }
