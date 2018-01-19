import sublime
import sublime_plugin
import subprocess
class PythonRunCommand(sublime_plugin.WindowCommand):
    def run(self):
        command = 'cmd /k "C:\Anaconda3\python.exe" %s' % sublime.active_window().active_view().file_name()
        subprocess.Popen(command)
