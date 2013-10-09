/*******************************************************************************
 * Authors: Brian Schott
 * Copyright: Brian Schott
 * Date: Oct  5 2013
 *
 * License:
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/

module stupidlog;

import std.stdio;
import core.vararg;

enum LogLevel : uint
{
	fatal = 0,
	error,
	info,
	trace
}

struct Log
{
	static void trace(T...)(lazy string message, T args)
	{
		if (level < LogLevel.trace) return;
		if (output is stdout)
			output.writeln("[\033[01;36mtrace\033[0m] " ~ message, args);
		else
			output.writeln("[trace] " ~ message, args);
	}

	static void info(T...)(lazy string message, T args)
	{
		if (level < LogLevel.info) return;
		if (output is stdout)
			output.writeln("[\033[01;32minfo\033[0m ] " ~ message, args);
		else
			output.writeln("[info ] " ~ message, args);
	}

	static void error(T...)(lazy string message, T args)
	{
		if (level < LogLevel.error) return;
		if (output is stdout)
			output.writeln("[\033[01;31merror\033[0m] " ~ message, args);
		else
			output.writeln("[error] " ~ message, args);
	}

	static void fatal(T...)(lazy string message, T args)
	{
		if (output is stdout)
			output.writeln("[\033[01;35mfatal\033[0m] " ~ message, args);
		else
			output.writeln("[fatal] " ~ message, args);
	}
	static LogLevel level;
	static File output;
}
