#include <gtest/gtest.h>
#include "lib.h"

TEST(simple_tests, test1)
{
    ASSERT_TRUE(true);

}

TEST(simple_tests, test_lib)
{
    ASSERT_EQ(add(1,2), 3);

}
