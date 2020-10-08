import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:inditask/utils/colors.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:inditask/utils/utils.dart';

class DatePicker extends StatefulWidget {
  final Function onDateChange;
  const DatePicker({this.onDateChange});
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double m = SizeConfig.safeBlockHorizontal;
    double fontSize = m * 5;

    CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        widget.onDateChange(date);
        this.setState(() => _currentDate = date);
      },
      dayPadding: 0,
      weekdayTextStyle: TextStyle(
          color: Colour.blue.color,
          fontSize: fontSize,
          fontFamily: "Monoserrat"),
      weekDayFormat: WeekdayFormat.short,
      daysTextStyle: TextStyle(
          color: Color(0xFF95989A),
          fontSize: fontSize,
          fontFamily: "Monoserrat"),
      weekendTextStyle: TextStyle(
          color: Color(0xFF95989A),
          fontSize: fontSize,
          fontFamily: "Monoserrat"),
      prevDaysTextStyle: TextStyle(
        fontSize: fontSize,
        color: Color(0xFFE5E5E5),
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: fontSize,
        color: Color(0xFFE5E5E5),
      ),
      selectedDayTextStyle: TextStyle(color: Colors.white, fontSize: fontSize),
      selectedDayButtonColor: Colour.blue.color,
      selectedDayBorderColor: Colour.blue.color,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekFormat: false,
      firstDayOfWeek: 1,
      height: SizeConfig.safeBlockVertical * 45,
      selectedDateTime: _currentDate,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: true,
      headerTextStyle: TextStyle(
        color: Colour.blue.color,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      showHeaderButton: false,
      todayTextStyle: TextStyle(
        color: Color(0xFF95989A),
        fontSize: fontSize,
        fontFamily: "Monoserrat",
      ),
      todayButtonColor: Colors.white,
      todayBorderColor: Colors.white,
      minSelectedDate: _currentDate.subtract(Duration(days: 1)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      inactiveDaysTextStyle: TextStyle(
          color: Color(0xFF95989A),
          fontSize: fontSize,
          fontFamily: "Monoserrat"),
      inactiveWeekendTextStyle: TextStyle(
          color: Color(0xFF95989A),
          fontSize: fontSize,
          fontFamily: "Monoserrat"),
      onCalendarChanged: (DateTime date) {},
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _calendarCarouselNoHeader,
    );
  }
}

class TimePicker extends StatelessWidget {
  final Function onTimeChange;
  const TimePicker({this.onTimeChange});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical * 45,
      child: TimePickerSpinner(
        normalTextStyle: TextStyle(
            fontSize: 50, color: Colour.grey.color, fontFamily: "Monoserrat"),
        highlightedTextStyle: TextStyle(
          fontSize: 70,
          color: Colour.blue.color,
          fontWeight: FontWeight.w700,
          fontFamily: "Monoserrat",
          decoration: TextDecoration.underline,
        ),
        spacing: 30,
        itemHeight: 80,
        itemWidth: 100,
        minutesInterval: 5,
        onTimeChange: (time) {
          this.onTimeChange(time);
        },
      ),
    );
  }
}

class ModalHeader extends StatelessWidget {
  final String text;
  const ModalHeader({this.text});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.safeBlockVertical * 7,
      width: SizeConfig.safeBlockHorizontal * 100,
      decoration: BoxDecoration(
        color: Colour.blue.color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final String text;
  final Function onSubmit;
  const NextButton({this.text, this.onSubmit});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ButtonTheme(
      minWidth: 140.0,
      height: SizeConfig.safeBlockVertical * 6,
      child: FlatButton(
        color: Colour.blue.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: Colour.white.color),
        ),
        padding: EdgeInsets.all(8.0),
        onPressed: onSubmit,
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
    );
  }
}

class DateTimeModal extends StatefulWidget {
  final Function onSubmit;
  const DateTimeModal({this.onSubmit});
  @override
  _DateTimeModalState createState() => _DateTimeModalState();
}

class _DateTimeModalState extends State<DateTimeModal> {
  bool _isCalendar = true;
  DateTime _datePicked = DateTime.now();
  DateTime _timePicked = DateTime.now();

  @override
  Widget build(Object context) {
    SizeConfig().init(context);

    void submit() {
      DateTime timeToReturn = DateTime(_datePicked.year, _datePicked.month,
          _datePicked.day, _timePicked.hour, _timePicked.minute, 0, 0);
      print("Returned time $timeToReturn");

      widget.onSubmit(timeToReturn);
    }

    void _onDatePicked(DateTime date) {
      setState(() {
        _datePicked = date;
        _isCalendar = false;
      });
    }

    void _onTimePicked(DateTime time) {
      setState(() {
        _timePicked = time;
      });
    }

    Widget datePickerColumn() {
      return Container(
        child: Column(children: [
          ModalHeader(text: "Set Date"),
          _isCalendar
              ? DatePicker(
                  onDateChange: _onDatePicked,
                )
              : TimePicker(),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 5,
          ),
          NextButton(
            text: "Next",
            onSubmit: () {
              setState(() {
                _isCalendar = false;
              });
            },
          )
        ]),
      );
    }

    Widget timePickerColumn() {
      return Column(children: [
        ModalHeader(text: "Set Time"),
        TimePicker(
          onTimeChange: _onTimePicked,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        ),
        NextButton(
          text: "Done",
          onSubmit: submit,
        )
      ]);
    }

    return _isCalendar ? datePickerColumn() : timePickerColumn();
  }
}
