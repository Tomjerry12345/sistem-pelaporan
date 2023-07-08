import 'package:flutter/material.dart';

import 'global_utils.dart';

navigatePush(page, {isRemove = false}) {
  if (isRemove) {
    Navigator.pushAndRemoveUntil(
        ctx, MaterialPageRoute(builder: (context) => page), (Route route) => false);
  } else {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

navigatePop() {
  Navigator.pop(ctx);
}
