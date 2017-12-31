module kinematics.core;


struct Vector3(T)
    if (__traits(isArithmetic, T))
{
    T x;
    T y;
    T z;
}

struct Vector4(T)
    if (__traits(isArithmetic, T))
{
    T x;
    T y;
    T z;
    T w;
}
