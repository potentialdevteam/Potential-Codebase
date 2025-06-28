import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/chat/models/event.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.85,
      height: height * 0.4,
      child: Card(
        elevation: 5,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(width * 0.05),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(width * 0.05),
            color: const Color.fromARGB(255, 17, 17, 17),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // EVENT IMAGE
              Container(
                width: width * 0.79,
                height: height * 0.20,
                margin: EdgeInsets.only(top: height * 0.01),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha(100),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadiusGeometry.circular(width * 0.05),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(width * 0.05),
                      child: Image.network(
                        event.eventImage,
                        width: width * 0.79,
                        height: height * 0.22,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.01,
                      left: width * 0.02,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadiusGeometry.circular(
                                width * 0.05,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: Text(
                              "${event.eventParticipants.length} going",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // EVENT DETAILS
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * 0.01,
                    children: [
                      Text(
                        event.eventName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.04,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            event.eventDate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                          Text(
                            " · ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${event.eventTime.hour}:${event.eventTime.minute} PM IST",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                          Text(
                            " · ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event.eventLocation,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${event.eventDistanceFromUser} KM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                          Text(
                            " · ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event.eventPartnerName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                          Text(
                            " · ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${event.eventRatings}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.03,
                                ),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.soulYellow,
                                size: width * 0.03,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(event.eventTags.length, (
                          index,
                        ) {
                          return Container(
                            margin: EdgeInsets.only(right: width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadiusGeometry.circular(
                                width * 0.01,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              event.eventTags[index].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.035,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
