using MyFinances.Types;

namespace MyFinances.Model
{
    public class ValidationError
    {
        public ValidationError(string desc, ErrorType type)
        {
            Description = desc;
            ErrorType = type;
        }

        public string Description { get; set; }

        public ErrorType ErrorType { get; set; }
    }
}
