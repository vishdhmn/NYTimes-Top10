//
//  NYConstants.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#ifndef NYConstants_h
#define NYConstants_h

#define API_KEY @"05268794adef4c099158cb29f525aaef"

#ifndef DEBUG_LOG
#ifdef DEBUG

#define DEBUG_LOG(...) NSLog(__VA_ARGS__)

#else

#define DEBUG_LOG(...)

#endif
#endif


#endif /* NYConstants_h */
